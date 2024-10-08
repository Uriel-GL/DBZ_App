import 'package:dbz_app/models/base_response.dart';
import 'package:dbz_app/models/personaje.dart';
import 'package:dbz_app/models/planet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// `Metodos Http para las peticiones`
enum HttpMethod {
  get,
}

/// `EndPoints base de la api`
enum EndPoint {
  allCharacters,
  characterById,
  allPlanets,
  planetById,
  nextPageCharacters,
  nextPagePlanets
}

/// `Clase Api donde se manejaran las llamadas a la Api`
class API {

  ///`URL BASE`
  static String get _baseUrl => 'https://dragonball-api.com/api';
  
  ///`Función la cual traera todos los personajes`
  static void getAllCharacters(Function(BaseResponse<Personaje>) callback) async {
    try {
      final response = await _fetchData(HttpMethod.get, EndPoint.allCharacters, _baseUrl);

      if(response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // debugPrint(json.toString());
        var data = BaseResponse<Personaje>.fromJson(
          json,
          (itemJson) => Personaje.fromJson(itemJson)
        );
        callback(data);
      }else {
        throw Exception("Error al obtener los datos de los personajes. ${response.statusCode}");
      }
    }
    catch (e) {
      debugPrint("Error: $e");
    }
  }

  ///`Función la cual traera la info de un personaje por su id`
  static void getCharacterById(int idPersonaje, Function(Personaje) callback) async {
    try {
      final response = await _fetchData(HttpMethod.get, EndPoint.characterById, _baseUrl, param: idPersonaje);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // var jsonString = const JsonEncoder.withIndent(' ').convert(json);
        // debugPrint(jsonString, wrapWidth: 1024);
        var data = Personaje.fromJson(json);
        callback(data);

      } else {
        throw Exception("Error al obtener los datos del id:$idPersonaje");
      }
    }
    catch (e) {
      debugPrint("Error: $e");
    }
  }

  ///`Función la cual traera todos los planetas`
  static void getAllPlanets(Function(BaseResponse<Planeta>) callback) async {
    try {
      final response = await _fetchData(HttpMethod.get, EndPoint.allPlanets, _baseUrl);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var data = BaseResponse.fromJson(
          json, 
          (itemJson) => Planeta.fromJson(itemJson)
        );
        callback(data);
      } else {
        throw Exception("Error al obtener los datos de los planetas. ${response.statusCode}");
      }
    }
    catch (e) {
      debugPrint("Error: $e");
    }
  }

  ///`Función la cual traera la info de un planeta por su id`
  static void getPlanetById(int idPlaneta, Function(Planeta) callback) async {
    try {
      final response = await _fetchData(HttpMethod.get, EndPoint.planetById, _baseUrl, param: idPlaneta);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // var jsonString = const JsonEncoder.withIndent(' ').convert(json);
        // debugPrint(jsonString, wrapWidth: 1024);
        var data = Planeta.fromJson(json);
        callback(data);
      }else {
        throw Exception("Error al obtener los datos del id:$idPlaneta");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  ///`Función la cual traera los personajes por número de pagina`
  static void getNextPageCharacters(int page, Function(BaseResponse<Personaje>) callback) async {
    try {
      final response = await _fetchData(HttpMethod.get, EndPoint.nextPageCharacters, _baseUrl, param: page);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // var jsonString = const JsonEncoder.withIndent(' ').convert(json);
        // debugPrint(jsonString, wrapWidth: 1024);
        var data = BaseResponse.fromJson(
          json, 
          (jsonItem) => Personaje.fromJson(jsonItem)
        );
        callback(data);
      } else {
        throw Exception("Ocurrio un error al intentar ir a la pagina $page");
      }
    }
    catch (e) {
      debugPrint("Error: $e");
    }
  }

  ///`Función la cual traera planetas por número de pagina`
  static void getNextPagePlanets(int page, Function(BaseResponse<Planeta>) callback) async {
    try {
      final response = await _fetchData(HttpMethod.get, EndPoint.nextPagePlanets, _baseUrl, param: page);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var data = BaseResponse.fromJson(
          json, 
          (jsonItem) => Planeta.fromJson(jsonItem)
        );
        callback(data);
      } else {
        throw Exception("Error al obtener la pagina $page");
      }
    }
    catch (e) {
      debugPrint("Error: $e");
    }
  }

  static Future<http.Response> _fetchData(HttpMethod method, EndPoint endPoint, String baseUrl, {int? param}) async {
    Uri url;
    switch(endPoint) {
      case EndPoint.allCharacters:
        url = Uri.parse("$baseUrl/characters");
      case EndPoint.characterById:
        url = Uri.parse("$baseUrl/characters/$param");
      case EndPoint.allPlanets:
        url = Uri.parse("$baseUrl/planets");
      case EndPoint.planetById:
        url = Uri.parse("$baseUrl/planets/$param");
      case EndPoint.nextPageCharacters:
        url = Uri.parse("$baseUrl/characters?page=$param&limit=10");
      case EndPoint.nextPagePlanets:
        url = Uri.parse("$baseUrl/planets?page=$param&limit=10");
      default:
        throw Exception("EndPoint invalido");
    }
    debugPrint("URL: $url");
    final headers = {
      'Content-Type': 'application/json'
    };

    switch(method){
      case HttpMethod.get:
        return await http.get(url, headers: headers);
      default: 
        throw Exception("Metodo Http invalido");
    }
  }
}
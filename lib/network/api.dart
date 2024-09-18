import 'package:dbz_app/models/base_response.dart';
import 'package:dbz_app/models/personaje.dart';
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
  planetById
}

/// `Clase Api donde se manejaran las llamadas a la Api`
class API {

  /// URL BASE
  static String get _baseUrl => 'https://dragonball-api.com/api';
  
  ///Función la cual traera todos los personajes
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

  ///Función la cual traera la info de un personaje por su id
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
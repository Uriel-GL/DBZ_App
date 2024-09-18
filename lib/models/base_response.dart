
class Meta {
  final int totalItems;
  final int itemCount;
  final int itemsPerPage;
  final int totalPages;
  final int currentPage;

  Meta({
    required this.totalItems,
    required this.itemCount,
    required this.itemsPerPage,
    required this.totalPages,
    required this.currentPage
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    totalItems: json['totalItems'], 
    itemCount: json['itemCount'], 
    itemsPerPage: json['itemsPerPage'], 
    totalPages: json['totalPages'], 
    currentPage: json['currentPage']
  );
}

class Link {
  final String first;
  final String previous;
  final String next;
  final String last;

  Link({
    required this.first,
    required this.previous,
    required this.next,
    required this.last
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    first: json['first'], 
    previous: json['previous'], 
    next: json['next'], 
    last: json['last']
  );
}

class BaseResponse<T> {
  final List<T> items;
  final Meta meta;
  final Link links;

  BaseResponse({
    required this.items,
    required this.meta,
    required this.links
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) jsonT) {
    var itemsJson = json['items'] as List;
    
    return BaseResponse<T>(
      items: itemsJson.map((itemJson) => jsonT(itemJson)).toList(),
      meta: Meta.fromJson(json['meta']),
      links: Link.fromJson(json['links']),
    );
  }
}
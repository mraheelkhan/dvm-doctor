class AnimalResponse {
  int? status;
  String? message;
  List<AnimalData>? data;

  AnimalResponse({this.status, this.data, this.message});

  factory AnimalResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<AnimalData> dataList =
        list.map((data) => AnimalData.fromJson(data)).toList();
    return AnimalResponse(
        status: json['status'], data: dataList, message: json['message']);
  }
}

class AnimalData {
  int? id;
  String animal_name;

  AnimalData({this.id, required this.animal_name});

  factory AnimalData.fromJson(Map<String, dynamic> json) {
    return AnimalData(
      id: json['id'],
      animal_name: json['animal_name'],
    );
  }
}

class AnimalCreateResponse {
  int? status;
  String? message;
  AnimalData? data;

  AnimalCreateResponse({this.status, this.data, this.message});

  factory AnimalCreateResponse.fromJson(Map<String, dynamic> json) {
    var dataList = AnimalData.fromJson(json['data']);
    return AnimalCreateResponse(
        status: json['status'], data: dataList, message: json['message']);
  }
}

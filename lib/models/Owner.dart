class Owner {
  int? status;
  String? message;
  List<Data>? data;

  Owner({this.status, this.data, this.message});

  factory Owner.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Data> dataList = list.map((data) => Data.fromJson(data)).toList();
    return Owner(
        status: json['status'], data: dataList, message: json['message']);
  }
}

class Data {
  int id;
  String name;
  String phone;
  String address;

  Data(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        phone: json['phone']);
  }
}

// class Owner {
//   int? status;
//   List<Data>? data;
//   String? message;

//   Owner({this.status, this.data, this.message});

//   Owner.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? name;
//   String? phone;
//   String? address;
//   String? createdAt;
//   String? updatedAt;

//   Data(
//       {this.id,
//       this.name,
//       this.phone,
//       this.address,
//       this.createdAt,
//       this.updatedAt});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     phone = json['phone'];
//     address = json['address'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['address'] = this.address;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

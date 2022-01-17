class Owner {
  int id;
  String name;
  // String address;
  // String phone;

  Owner({
    required this.id,
    required this.name,
    // required this.address,
    // required this.phone
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      // address: json['address'],
      // phone: json['phone']
    );
  }
}

// class OwnerResponse {
//   bool status;
//   List<Owner> data;
//   String message;

//   OwnerResponse({
//     required this.status,
//     required this.data,
//     required this.message,
//   });

//   factory OwnerResponse.fromJson(Map<String, dynamic> json) {
//     return OwnerResponse(
//         status: json['status'], data: json['data'], message: json['message']);
//   }
// }

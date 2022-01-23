import 'dart:convert';
import 'dart:io';

import 'package:dvm_doctor/models/AnimalResponse.dart';
import 'package:dvm_doctor/models/OwnerResponse.dart';
import 'package:http/http.dart' as http;

class ApiService {
  late String token;

  ApiService(String token) {
    this.token = token;
  }

  final String baseUrl =
      // 'http://192.168.10.17/Laravel-Flutter-Course-API/public/api/';
      'http://db3d-111-119-177-41.ngrok.io/api/';

  /* ##### Model Owner #### */
  Future<OwnerResponse> fetchOwners() async {
    OwnerResponse _owner;
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'owners'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    var owner = jsonDecode(response.body);

    _owner = OwnerResponse.fromJson(owner);
    return _owner;
  }

  Future<OwnerCreateResponse> addOwner(OwnerData owner) async {
    String uri = baseUrl + 'owners';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'name': owner.name,
          'address': owner.address,
          'phone': owner.phone
        }));
    if (response.statusCode != 201) {
      throw Exception('Something went wrong while create! Error code: ' +
          response.statusCode.toString() +
          ' ' +
          response.body);
    }
    return OwnerCreateResponse.fromJson(jsonDecode(response.body));
  }

  Future<OwnerData> updateOwner(OwnerData owner) async {
    String uri = baseUrl + 'owners/' + owner.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'name': owner.name,
          'address': owner.address,
          'phone': owner.phone
        }));

    if (response.statusCode != 200) {
      throw Exception('Something went wrong! Error code: ' +
          response.statusCode.toString());
    }
    return OwnerData.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteOwner(int id) async {
    String uri = baseUrl + 'owners/' + id.toString();

    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Something went wrong while deleting! Error code: ' +
          response.statusCode.toString());
    }
  }

  /// #### Model Animal ####

  Future<AnimalResponse> fetchAnimals() async {
    AnimalResponse _animal;
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'animals'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    var owner = jsonDecode(response.body);

    _animal = AnimalResponse.fromJson(owner);
    return _animal;
  }

  Future<AnimalCreateResponse> addAnimal(AnimalData animal) async {
    String uri = baseUrl + 'animals';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'animal_name': animal.animal_name,
        }));
    if (response.statusCode != 201) {
      throw Exception('Something went wrong while create! Error code: ' +
          response.statusCode.toString() +
          ' ' +
          response.body);
    }
    return AnimalCreateResponse.fromJson(jsonDecode(response.body));
  }

  Future<AnimalData> updateAnimal(AnimalData animal) async {
    String uri = baseUrl + 'animals/' + animal.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'animal_name': animal.animal_name,
        }));

    if (response.statusCode != 200) {
      throw Exception('Something went wrong! Error code: ' +
          response.statusCode.toString());
    }
    return AnimalData.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteAnimal(int id) async {
    String uri = baseUrl + 'animals/' + id.toString();

    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Something went wrong while deleting! Error code: ' +
          response.statusCode.toString());
    }
  }

  /// #### Register and Login ####
  Future<String> register(String name, String email, String password,
      String confirmPassword, String deviceName) async {
    String uri = baseUrl + 'auth/register';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'device_name': deviceName,
        }));
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      int index = 1;
      errors.forEach((key, value) {
        value.forEach((error) {
          errorMessage += index.toString() + '. ' + error + '\n';
          index++;
        });
      });

      throw Exception(errorMessage);
    }
    return response.body;
  }

  Future<String> login(String email, String password, String deviceName) async {
    String uri = baseUrl + 'auth/login';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': deviceName,
        }));
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      int index = 1;
      errors.forEach((key, value) {
        value.forEach((error) {
          errorMessage += index.toString() + '. ' + error + '\n';
          index++;
        });
      });

      throw Exception(errorMessage);
    }
    return response.body;
  }
}

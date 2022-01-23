import 'package:dvm_doctor/models/AnimalResponse.dart';
import 'package:flutter/material.dart';
import 'package:dvm_doctor/providers/AuthProvider.dart';
import 'package:dvm_doctor/services/Api.dart';

class AnimalProvider extends ChangeNotifier {
  AnimalResponse animals = AnimalResponse();
  late ApiService apiService;
  late AuthProvider authProvider;

  AnimalProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);
    // this line above is the main part
    init();
  }

  Future init() async {
    animals = await apiService.fetchAnimals();
    notifyListeners();
  }

  Future addAnimal(AnimalData animal) async {
    try {
      AnimalCreateResponse addAnimal = await apiService.addAnimal(animal);
      animals.data?.add(addAnimal.data!);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future updateAnimal(AnimalData animal) async {
    try {
      AnimalData updatedAnimal = await apiService.updateAnimal(animal);
      int? index = animals.data!.indexOf(animal);

      animals.data![index] = updatedAnimal;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future deleteAnimal(AnimalData animal) async {
    try {
      await apiService.deleteAnimal(animal.id!.toInt());
      animals.data!.remove(animal);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}

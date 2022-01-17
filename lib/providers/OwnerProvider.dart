import 'package:dvm_doctor/models/Owner.dart';
import 'package:flutter/material.dart';
import 'package:dvm_doctor/providers/AuthProvider.dart';
import 'package:dvm_doctor/services/Api.dart';

class OwnerProvider extends ChangeNotifier {
  List<Owner> owners = [];

  late ApiService apiService;
  late AuthProvider authProvider;

  OwnerProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);
    // this line above is the main part
    init();
  }

  Future init() async {
    owners = await apiService.fetchOwners();
    notifyListeners();
  }

  Future addOwner(String name) async {
    try {
      Owner addOwner = await apiService.addOwner(name);
      owners.add(addOwner);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future updateOwner(Owner owner) async {
    try {
      Owner updatedOwner = await apiService.updateOwner(owner);
      int index = owners.indexOf(owner);

      owners[index] = updatedOwner;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future deleteOwner(Owner owner) async {
    try {
      await apiService.deleteOwner(owner.id);
      owners.remove(owner);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}

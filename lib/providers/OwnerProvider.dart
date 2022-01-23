import 'package:dvm_doctor/models/OwnerResponse.dart';
import 'package:flutter/material.dart';
import 'package:dvm_doctor/providers/AuthProvider.dart';
import 'package:dvm_doctor/services/Api.dart';

class OwnerProvider extends ChangeNotifier {
  OwnerResponse owners = OwnerResponse();
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

  Future addOwner(OwnerData owner) async {
    try {
      OwnerCreateResponse addOwner = await apiService.addOwner(owner);
      owners.data?.add(addOwner.data!);
      // owners.add(addOwner);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future updateOwner(OwnerData owner) async {
    try {
      OwnerData updatedOwner = await apiService.updateOwner(owner);
      int? index = owners.data!.indexOf(owner);

      owners.data![index] = updatedOwner;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future deleteOwner(OwnerData owner) async {
    try {
      await apiService.deleteOwner(owner.id!.toInt());
      print(owners.data!.remove(owner));

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}

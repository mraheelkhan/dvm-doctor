import 'dart:io';
import 'package:dvm_doctor/models/AnimalResponse.dart';
import 'package:flutter/material.dart';
import 'package:dvm_doctor/services/Api.dart';
import 'dart:convert';

class AnimalEdit extends StatefulWidget {
  // final OwnerResponse owner;
  final AnimalData animal;
  final Function ownerCallback;
  AnimalEdit(this.animal, this.ownerCallback, {Key? key}) : super(key: key);

  @override
  _AnimalEditState createState() => _AnimalEditState();
}

class _AnimalEditState extends State<AnimalEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final animalNameController = TextEditingController();
  ApiService apiService = ApiService('');
  String errorMessage = '';

  @override
  void initState() {
    animalNameController.text = widget.animal.animal_name;
    super.initState();
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.animal.animal_name = animalNameController.text;

    await widget.ownerCallback(widget.animal);
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) => setState(() {
                      errorMessage = '';
                    }),
                    controller: animalNameController,
                    //initialValue:
                    //    category.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter animal name';
                      }
                      if (value.length <= 3) {
                        return 'Animal name should be greater than 3 letters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Animal Name',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            saveCategory();
                          },
                          child: Text('Save'))),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close')),
                  Text(errorMessage, style: TextStyle(color: Colors.red))
                ],
              ))),
    );
  }
}

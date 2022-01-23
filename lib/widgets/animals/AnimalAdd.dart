import 'package:dvm_doctor/models/AnimalResponse.dart';
import 'package:dvm_doctor/models/OwnerResponse.dart';
import 'package:flutter/material.dart';

class AnimalAdd extends StatefulWidget {
  final Function animalCallback;
  AnimalAdd(this.animalCallback, {Key? key}) : super(key: key);

  @override
  _AnimalAddState createState() => _AnimalAddState();
}

class _AnimalAddState extends State<AnimalAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final animalNameController = TextEditingController();

  String errorMessage = '';
  Future addAnimal() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }
    AnimalData animalData = AnimalData(
      animal_name: animalNameController.text,
    );
    await widget.animalCallback(animalData);

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
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter animal Name';
                      }
                      if (value.length < 3) {
                        return 'Animal name should be greater than 3 letters.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Animal Name',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            addAnimal();
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

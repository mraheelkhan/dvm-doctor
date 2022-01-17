import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dvm_doctor/models/Owner.dart';
import 'package:dvm_doctor/services/Api.dart';
import 'dart:convert';

class OwnerEdit extends StatefulWidget {
  final Owner owner;
  final Function ownerCallback;
  OwnerEdit(this.owner, this.ownerCallback, {Key? key}) : super(key: key);

  @override
  _OwnerEditState createState() => _OwnerEditState();
}

class _OwnerEditState extends State<OwnerEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  ApiService apiService = ApiService('');
  String errorMessage = '';

  @override
  void initState() {
    ownerNameController.text = widget.owner.name;
    super.initState();
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.owner.name = ownerNameController.text;

    await widget.ownerCallback(widget.owner);
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
                    controller: ownerNameController,
                    //initialValue:
                    //    category.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter owner Name';
                      }
                      if (value.length <= 3) {
                        return 'Owner name should be greater than 3 letters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Owner Name',
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

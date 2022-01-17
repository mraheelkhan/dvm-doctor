import 'package:flutter/material.dart';

class OwnerAdd extends StatefulWidget {
  final Function ownerCallback;
  OwnerAdd(this.ownerCallback, {Key? key}) : super(key: key);

  @override
  _OwnerAddState createState() => _OwnerAddState();
}

class _OwnerAddState extends State<OwnerAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  String errorMessage = '';
  Future addOwner() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    await widget.ownerCallback(ownerNameController.text);

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
                            addOwner();
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

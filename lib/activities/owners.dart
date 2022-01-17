import 'package:dvm_doctor/widgets/OwnerAdd.dart';
import 'package:dvm_doctor/widgets/OwnerEdit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dvm_doctor/models/Owner.dart';
import 'package:dvm_doctor/providers/OwnerProvider.dart';

class Owners extends StatefulWidget {
  @override
  _OwnersState createState() => _OwnersState();
}

class _OwnersState extends State<Owners> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OwnerProvider>(context);

    List<Owner> Owners = provider.owners;
    return Scaffold(
      appBar: AppBar(
        title: Text('Owners'),
      ),
      body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Center(
            child: ListView.builder(
                itemCount: Owners.length,
                itemBuilder: (BuildContext context, int index) {
                  Owner owner = Owners[index];
                  return ListTile(
                      title: Text(
                        owner.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return OwnerEdit(
                                          owner, provider.updateOwner);
                                    });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 24.0,
                              )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text('Do you want to delete?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () => deleteCategory(
                                                  provider.deleteOwner, owner),
                                              child: Text('Delete')),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancel')),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 24.0,
                              ))
                        ],
                      ));
                }),
          )),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return OwnerAdd(provider.addOwner);
                });
          },
          child: Icon(Icons.add)),
    );
  }

  Future deleteCategory(Function callback, Owner owner) async {
    await callback(owner);
    Navigator.pop(context);
  }
}

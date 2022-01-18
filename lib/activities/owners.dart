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

    Owner Owners = provider.owners;
    return Scaffold(
      appBar: AppBar(
        title: Text('Owners'),
      ),
      body: Container(
          // color: Theme.of(context).primaryColorDark,
          child: Center(
        child: () {
          if (Owners.data != null) {
            return ListView.builder(
                itemCount: Owners.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Data owner = Owners.data![index];
                  return ListTile(
                      title: Text(
                        owner.name,
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                // showModalBottomSheet(
                                //     context: context,
                                //     isScrollControlled: true,
                                //     builder: (context) {
                                //       return OwnerEdit(
                                //           owner, provider.updateOwner);
                                //     });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 24.0,
                              )),
                          IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 24.0,
                              ))
                        ],
                      ));
                });
          } else {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            );
          }
        }(),
      )),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            // showModalBottomSheet(
            //     context: context,
            //     isScrollControlled: true,
            //     builder: (context) {
            //       return OwnerAdd(provider.addOwner);
            //     });
          },
          child: Icon(Icons.add)),
    );
  }

  Future deleteCategory(Function callback, Owner owner) async {
    await callback(owner);
    Navigator.pop(context);
  }
}

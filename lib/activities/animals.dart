import 'package:dvm_doctor/models/AnimalResponse.dart';
import 'package:dvm_doctor/providers/AnimalProvider.dart';
import 'package:dvm_doctor/widgets/animals/AnimalEdit.dart';
import 'package:dvm_doctor/widgets/animals/AnimalAdd.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Animals extends StatefulWidget {
  @override
  _AnimalsState createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimalProvider>(context);

    AnimalResponse animals = provider.animals;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animals'),
      ),
      body: Container(
          // color: Theme.of(context).primaryColorDark,
          child: Center(
        child: () {
          if (animals.data != null) {
            return ListView.builder(
                itemCount: animals.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  AnimalData animal = animals.data![index];
                  return ListTile(
                      title: Text(
                        animal.animal_name,
                        style: TextStyle(color: Colors.black),
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
                                      return AnimalEdit(
                                          animal, provider.updateAnimal);
                                    });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
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
                                              onPressed: () => deleteAnimal(
                                                  provider.deleteAnimal,
                                                  animal,
                                                  context),
                                              child: Text('Delete')),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancel')),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 24.0,
                              ))
                        ],
                      ));
                });
          } else {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            );
          }
        }(),
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return AnimalAdd(provider.addAnimal);
                });
          },
          child: const Icon(Icons.add)),
    );
  }

  Future deleteAnimal(Function callback, AnimalData animal, context) async {
    await callback(animal);
    Navigator.pop(context);
  }
}

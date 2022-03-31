import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/models/load_list_repository.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/repositories/list_repository.dart';

class AddItem extends StatelessWidget {
  AddItem({
    Key? key,
    required this.type,
    required this.onSave,
    int? id,
    int? currFolderId,
  }) : super(key: key) {
    nameType = type == ItemType.FOLDER ? 'Pasta' : 'Lista';
    this.id = id ?? -1;
    this.currFolderId = currFolderId ?? -1;
    folderId = this.currFolderId == -1 ? -1 : loadList[this.currFolderId].id;
    currentColor = this.id == -1 ? Colors.amber : loadList[id!].color;
  }

  List<Item> loadList = ListRepository.instance.loadList;
  final ItemType type;
  late String nameType;
  var id;
  var currFolderId;
  Color currentColor = Colors.amber;
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int folderId = -1;

  final void Function() onSave;

  void changeColor(Color color) {
    currentColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar $nameType'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: id != -1
                    ? (currFolderId != -1
                        ? (loadList[currFolderId] as FolderItem).iList[id].name
                        : loadList[id].name)
                    : '',
                decoration: InputDecoration(
                  label: Text('Nome'),
                ),
                onSaved: (value) {
                  name = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite um nome válido';
                  }
                },
              ),
              if (type == ItemType.LIST)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      label: Text('Pasta'),
                    ),
                    items: loadList
                        .where((element) => element.type == ItemType.FOLDER)
                        .map((e) {
                      return DropdownMenuItem(
                        child: Row(children: [
                          const Icon(Icons.folder),
                          Padding(
                            child: Text(e.name),
                            padding: EdgeInsets.only(left: 10),
                          )
                        ]),
                        value: (e.id),
                      );
                    }).toList(),
                    value:
                        currFolderId != -1 ? loadList[currFolderId].id : null,
                    onChanged: (value) {
                      folderId = value as int;
                    },
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: HueRingPicker(
                    colorPickerHeight: 200,
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Item item = type == ItemType.FOLDER
                          ? FolderItem(
                              id: loadList.length,
                              name: name,
                              color: currentColor,
                              iList: [])
                          : ListItem(
                              id: loadList.length,
                              name: name,
                              color: currentColor);
                      if (folderId == -1) {
                        if (id != -1) {
                          loadList[id].name = name;
                          loadList[id].color = currentColor;
                        } else {
                          loadList.add(item);
                        }
                      } else {
                        if (id != -1) {
                          print(folderId);
                          print(loadList[currFolderId].id);
                          if (loadList[currFolderId].id == folderId) {
                            var iList =
                                (loadList[currFolderId] as FolderItem).iList;
                            print(iList[id].name);
                            iList[id].name = name;
                            iList[id].color = currentColor;
                          }
                        } else {
                          (loadList.firstWhere(
                                      (element) => element.id == folderId)
                                  as FolderItem)
                              .iList
                              .add(item as ListItem);
                        }
                      }

                      onSave();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Criar $nameType'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

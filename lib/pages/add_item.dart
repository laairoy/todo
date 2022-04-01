import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/models/item_list.dart';
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
    currentColor = this.id == -1
        ? Colors.amber
        : this.currFolderId == -1
            ? loadList[id!].color
            : (loadList[currFolderId!] as FolderItem).iList[id!].color;
  }

  List<Item> loadList = ListRepository.instance.loadList;
  int newId = ListRepository.instance.count;
  final ItemType type;
  late String nameType;
  var id;
  var currFolderId;
  Color currentColor = Colors.amber;
  final _formKey = GlobalKey<FormState>();
  final _dropKey = GlobalKey<FormFieldState>();
  String name = '';
  int folderId = -1;

  final void Function() onSave;

  void changeColor(Color color) {
    currentColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Adicionar $nameType'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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
                Row(
                  children: [
                    Expanded(
                      //padding: const EdgeInsets.only(top: 20.0),
                      child: DropdownButtonFormField(
                        key: _dropKey,
                        decoration: InputDecoration(
                          label: Text('Pasta'),
                        ),
                        items: loadList
                            .where((element) => element.type == ItemType.FOLDER)
                            .map((e) {
                          return DropdownMenuItem(
                            child: Row(children: [
                              Icon(
                                Icons.folder,
                                color: e.color,
                              ),
                              Padding(
                                child: Text(e.name),
                                padding: EdgeInsets.only(left: 10),
                              )
                            ]),
                            value: (e.id),
                          );
                        }).toList(),
                        value: currFolderId != -1
                            ? loadList[currFolderId].id
                            : null,
                        onChanged: (value) {
                          folderId = value != null ? value as int : -1;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: IconButton(
                        onPressed: () {
                          _dropKey.currentState!.didChange(null);
                        },
                        icon: Icon(Icons.folder_off),
                      ),
                    ),
                  ],
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
                              id: newId,
                              name: name,
                              color: currentColor,
                              iList: [])
                          : ListItem(
                              id: newId, name: name, color: currentColor);
                      if (folderId == -1) {
                        if (id != -1 && currFolderId != -1) {
                          ListItem listItem =
                              (loadList[currFolderId] as FolderItem)
                                  .iList
                                  .removeAt(id);
                          loadList.add(listItem);
                        }
                        if (id != -1) {
                          loadList[id].name = name;
                          loadList[id].color = currentColor;
                        } else {
                          loadList.add(item);
                        }
                      } else {
                        if (id != -1 && currFolderId == -1) {
                          ListItem listItem = loadList.removeAt(id) as ListItem;
                          (loadList.firstWhere(
                                      (element) => element.id == folderId)
                                  as FolderItem)
                              .iList
                              .add(listItem);
                        } else if (id != -1) {
                          if (loadList[currFolderId].id == folderId) {
                            var iList =
                                (loadList[currFolderId] as FolderItem).iList;
                            iList[id].name = name;
                            iList[id].color = currentColor;
                          } else {
                            ListItem listItem =
                                (loadList[currFolderId] as FolderItem)
                                    .iList
                                    .removeAt(id);
                            (loadList.firstWhere(
                                        (element) => element.id == folderId)
                                    as FolderItem)
                                .iList
                                .add(listItem);
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
                  child: Text('Salvar $nameType'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

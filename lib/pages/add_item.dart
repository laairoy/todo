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
  }) : super(key: key) {
    nameType = type == ItemType.FOLDER ? 'Pasta' : 'Lista';
  }

  ListRepository listRepository = ListRepository.instance;
  final ItemType type;
  late String nameType;
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  label: Text('Nome'),
                ),
                onSaved: (value) {
                  name = value ?? '';
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
                    items: listRepository.loadList
                        .where((element) => element.type == ItemType.FOLDER)
                        .map((e) {
                      return DropdownMenuItem(
                        child: Text(e.name),
                        value: e.id,
                      );
                    }).toList(),
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
                      var loadList = listRepository.loadList;
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
                        loadList.add(item);
                      } else {
                        (loadList.firstWhere((element) => element.id == folderId) as FolderItem)
                            .iList
                            .add(item as ListItem);
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

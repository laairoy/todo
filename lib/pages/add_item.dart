import 'package:flutter/material.dart';
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
    currentColor = this.id == -1 ? Colors.amber : loadList[id!].color;
  }

  List<Item> loadList = ListRepository.instance.loadList;
  int newId = ListRepository.instance.count;
  final ItemType type;
  late String nameType;
  late var id;
  late var currFolderId;
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
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: id != -1 ? loadList[id].name : '',
                decoration: const InputDecoration(
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
                          label: const Text('Pasta'),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _dropKey.currentState!.didChange(null);
                            },
                            icon: const Icon(Icons.highlight_remove),
                          ),
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
                                padding: const EdgeInsets.only(left: 10),
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
                  ],
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
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
                            )
                          : ListItem(
                              id: newId,
                              name: name,
                              color: currentColor,
                              folderId: folderId);
                      if (id == -1) {
                        loadList.add(item);
                      } else {
                        loadList[id].name = name;
                        loadList[id].color = currentColor;
                        if (type == ItemType.LIST) {
                          (loadList[id] as ListItem).folderId = folderId;
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

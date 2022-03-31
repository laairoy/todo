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
        padding: EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  //hintText: 'digite o nome',
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
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
                      loadList.add(item);
                      loadList.forEach((element) => print(element.name));
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

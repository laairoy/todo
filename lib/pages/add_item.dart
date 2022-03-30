import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/models/load_list_repository.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddItem extends StatelessWidget {
  AddItem({Key? key, required this.type}) : super(key: key) {
    name = type == ItemType.FOLDER ? 'Pasta' : 'Lista';
  }

  final ItemType type;
  late String name;
  Color currentColor = Colors.amber;

  void changeColor(Color color) {
    currentColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar $name'),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  //hintText: 'digite o nome',
                  label: Text('Nome'),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: HueRingPicker(
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Criar $name'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

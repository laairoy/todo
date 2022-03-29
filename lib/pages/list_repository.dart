
import 'package:flutter/material.dart';
import 'package:todo/pages/load_list.dart';

class ListRepository {
  List<Item> loadList = [
    ListItem(id: 0, name: 'Livros', color: Colors.red, type: ItemType.LIST),
    ListItem(id: 1, name: 'UTFPR', color: Colors.green, type: ItemType.FOLDER),
    ListItem(id: 2, name: 'Tarefas', color: Colors.blueAccent, type: ItemType.FOLDER),
    ListItem(id: 3, name: 'Casa', color: Colors.purple, type: ItemType.LIST),

  ];
}
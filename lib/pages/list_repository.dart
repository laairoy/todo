import 'package:flutter/material.dart';
import 'package:todo/pages/load_list.dart';

class ListRepository {
  List<Item> loadList = [
    ListItem(id: 0, name: 'Livros', color: Colors.red),
    FolderItem(
        id: 1,
        name: 'UTFPR',
        color: Colors.green,
        iList: [ListItem(id: 5, name: 'Testes', color: Colors.blueAccent)]),
    FolderItem(id: 2, name: 'Tarefas', color: Colors.blueAccent, iList: [
      ListItem(id: 6, name: 'Trabalho', color: Colors.greenAccent),
      ListItem(id: 8, name: 'Escola', color: Colors.yellowAccent),
    ]),
    ListItem(id: 3, name: 'Casa', color: Colors.purple),
    ListItem(id: 3, name: 'Casa', color: Colors.purple),
  ];
}

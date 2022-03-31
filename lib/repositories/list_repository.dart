import 'package:flutter/material.dart';
import 'package:todo/models/load_list_repository.dart';

class ListRepository {

  List<Item> loadList = [];

  ListRepository() {
    loadList = [
      ListItem(id: 1, name: 'Livros', color: Colors.red),
      FolderItem(
          id: 2,
          name: 'UTFPR',
          color: Colors.green,
          iList: [ListItem(id: 3, name: 'Testes', color: Colors.blueAccent)]),
      FolderItem(id: 4, name: 'Tarefas', color: Colors.blueAccent, iList: [
        ListItem(id: 5, name: 'Trabalho', color: Colors.greenAccent),
        ListItem(id: 6, name: 'Escola', color: Colors.yellowAccent),
      ]),
      ListItem(id: 7, name: 'Casa', color: Colors.purple),
    ];
  }

}

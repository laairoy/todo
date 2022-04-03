import 'package:flutter/material.dart';
import 'package:todo/models/item_list.dart';

class ListRepository {
  static final ListRepository _instance = ListRepository._();
  List<Item> loadList = [];
  int _count = 7;

  int get count => _count++;

  static ListRepository get instance => _instance;

  ListRepository._() {
    loadList = [
      ListItem(id: 0, name: 'Livros', color: Colors.red),
      FolderItem(id: 1, name: 'UTFPR', color: Colors.green),
      ListItem(id: 2, name: 'Testes', color: Colors.blueAccent, folderId: 1),
      FolderItem(id: 3, name: 'Tarefas', color: Colors.blueAccent),
      ListItem(id: 4, name: 'Trabalho', color: Colors.greenAccent, folderId: 3),
      ListItem(id: 5, name: 'Escola', color: Colors.yellowAccent, folderId: 3),
      ListItem(id: 6, name: 'Casa', color: Colors.purple),
    ];
  }
}

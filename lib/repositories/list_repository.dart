import 'package:flutter/material.dart';
import 'package:todo/models/item_list.dart';

class ListRepository {
  static final ListRepository _instance = ListRepository._();
  List<Item> loadList = [];
  int _count = 8;

  int get count => _count++;

  static ListRepository get instance => _instance;

  ListRepository._() {
    loadList = [
      ListItem(id: 1, name: 'Livros', color: Colors.red),
      FolderItem(id: 2, name: 'UTFPR', color: Colors.green),
      ListItem(id: 3, name: 'Testes', color: Colors.blueAccent, folderId: 2),
      FolderItem(id: 4, name: 'Tarefas', color: Colors.blueAccent),
      ListItem(id: 5, name: 'Trabalho', color: Colors.greenAccent, folderId: 4),
      ListItem(id: 6, name: 'Escola', color: Colors.yellowAccent, folderId: 4),
      ListItem(id: 7, name: 'Casa', color: Colors.purple),
    ];
  }
}

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
      ListItem(name: 'Livros', color: Colors.red),
      FolderItem(name: 'UTFPR', color: Colors.green),
      ListItem(name: 'Testes', color: Colors.blueAccent, folderId: 1),
      FolderItem(name: 'Tarefas', color: Colors.blueAccent),
      ListItem(name: 'Trabalho', color: Colors.greenAccent, folderId: 3),
      ListItem(name: 'Escola', color: Colors.yellowAccent, folderId: 3),
      ListItem(name: 'Casa', color: Colors.purple),
    ];
  }
}

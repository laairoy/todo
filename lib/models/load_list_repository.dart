import 'package:flutter/material.dart';

abstract class Item {
  int id;
  String name;
  Color color;
  ItemType type;

  Item({
    required this.id,
    required this.name,
    required this.color,
    required this.type,
  });
}

class FolderItem extends Item {
  List<ListItem> iList;
  FolderItem({required int id, required String name, required Color color, required this.iList})
      : super(id: id, name: name, color: color, type: ItemType.FOLDER);
}

class ListItem extends Item {
  ListItem({required int id, required String name, required Color color})
      : super(id: id, name: name, color: color, type: ItemType.LIST);
}

enum ItemType {
  FOLDER,
  LIST,
}
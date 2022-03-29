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
  FolderItem({required int id, required String name, required Color color, required ItemType type})
      : super(id: id, name: name, color: color, type: type);
}

class ListItem extends Item {
  ListItem({required int id, required String name, required Color color, required ItemType type})
      : super(id: id, name: name, color: color, type: type);
}

enum ItemType {
  FOLDER,
  LIST,
}
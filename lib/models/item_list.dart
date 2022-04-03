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
  FolderItem({required int id, required String name, required Color color})
      : super(id: id, name: name, color: color, type: ItemType.FOLDER);
}

class ListItem extends Item {
  int folderId = -1;
  ListItem({required int id, required String name, required Color color,int? folderId})
      : super(id: id, name: name, color: color, type: ItemType.LIST){
    this.folderId = folderId ?? -1;
  }
}

enum ItemType {
  FOLDER,
  LIST,
}
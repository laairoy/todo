import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'item_list.g.dart';

abstract class Item extends HiveObject{
  //@HiveField(0)
  //late int key;
  @HiveField(1)
  late int orderId;
  @HiveField(2)
  String name;
  @HiveField(3)
  Color color;
  @HiveField(4)
  ItemType type;

  Item({
    required this.name,
    required this.color,
    required this.type,
  }){
    orderId = DateTime.now().microsecondsSinceEpoch;
  }
}

@HiveType(typeId: 0)
class FolderItem extends Item {
  FolderItem({required String name, required Color color})
      : super(name: name, color: color, type: ItemType.FOLDER);
}

@HiveType(typeId: 1)
class ListItem extends Item {
  @HiveField(5)
  int folderId = -1;
  ListItem({required String name, required Color color,int? folderId})
      : super(name: name, color: color, type: ItemType.LIST){
    this.folderId = folderId ?? -1;
  }
}

@HiveType(typeId: 2)
enum ItemType {
  @HiveField(0)
  FOLDER,
  @HiveField(1)
  LIST,
}
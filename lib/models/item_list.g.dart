// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderItemAdapter extends TypeAdapter<FolderItem> {
  @override
  final int typeId = 0;

  @override
  FolderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderItem(
      name: fields[2] as String,
      color: fields[3] as Color,
    )
      ..orderId = fields[1] as int
      ..type = fields[4] as ItemType;
  }

  @override
  void write(BinaryWriter writer, FolderItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ListItemAdapter extends TypeAdapter<ListItem> {
  @override
  final int typeId = 1;

  @override
  ListItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListItem(
      name: fields[2] as String,
      color: fields[3] as Color,
      folderId: fields[5] as int?,
    )
      ..orderId = fields[1] as int
      ..type = fields[4] as ItemType;
  }

  @override
  void write(BinaryWriter writer, ListItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(5)
      ..write(obj.folderId)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemTypeAdapter extends TypeAdapter<ItemType> {
  @override
  final int typeId = 2;

  @override
  ItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemType.FOLDER;
      case 1:
        return ItemType.LIST;
      default:
        return ItemType.FOLDER;
    }
  }

  @override
  void write(BinaryWriter writer, ItemType obj) {
    switch (obj) {
      case ItemType.FOLDER:
        writer.writeByte(0);
        break;
      case ItemType.LIST:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

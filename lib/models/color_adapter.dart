
import 'dart:ui';
import 'package:hive/hive.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) {
    return Color(reader.readInt());
  }

  @override
  int typeId = 3;

  @override
  void write(BinaryWriter writer, obj) {
    writer.writeInt(obj.value);
  }

}

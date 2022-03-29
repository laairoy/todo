import 'package:flutter/material.dart';

class FixedList {
  List<ItemList> fixedList = [
    ItemList(
      title: 'Hoje',
      icon: const Icon(
        Icons.sunny,
        color: Colors.green,
      ),
    ),
    ItemList(
      title: 'Amanhã',
      icon: const Icon(Icons.wb_twilight, color: Colors.redAccent),
    ),
    ItemList(
      title: 'Em breve',
      icon: const Icon(Icons.calendar_month, color: Colors.blueAccent),
    ),
    ItemList(
      title: 'Algum dia',
      icon: const Icon(Icons.calendar_today, color: Colors.deepPurpleAccent),
    ),
  ];
}

class ItemList {
  String title;
  Icon icon;

  ItemList({
    required this.title,
    required this.icon,
  });
}

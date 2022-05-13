import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/color_adapter.dart';
import 'package:todo/models/item_list.dart';
import 'package:todo/models/login_data.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/pages/splashscreen_page.dart';
import 'package:todo/pages/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(ListItemAdapter());
  Hive.registerAdapter(TaskListAdapter());
  Hive.registerAdapter(FolderItemAdapter());
  Hive.registerAdapter(ItemTypeAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(LoginDataAdapter());
  //Hive.registerAdapter(ListTaskAdapter());
  //await Hive.openBox("item_list");
  //await Hive.openBox("task_list");
  await Hive.openBox("cadastro");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/color_adapter.dart';
import 'package:todo/models/item_list.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/pages/splashscreen_page.dart';
import 'package:todo/pages/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(ListItemAdapter());
  Hive.registerAdapter(FolderItemAdapter());
  Hive.registerAdapter(ItemTypeAdapter());
  Hive.registerAdapter(ColorAdapter());
  //Hive.registerAdapter(ListTaskAdapter());
  await Hive.openBox("item_list");
  await Hive.openBox("task_list");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  void Funcao() => {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(
              title: 'nada',
              onSave: Funcao,
            ),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
*/
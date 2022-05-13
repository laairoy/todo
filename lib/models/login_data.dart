
import 'package:hive/hive.dart';

part 'login_data.g.dart';

@HiveType(typeId: 10)
class LoginData extends HiveObject{
  @HiveField(0)
  String nome;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  bool logged;
  @HiveField(4)
  late String avatar;

  LoginData({
    required this.nome,
    required this.email,
    required this.password,
    required this.logged,
  }){
    avatar = "images/person.png";
  }
}
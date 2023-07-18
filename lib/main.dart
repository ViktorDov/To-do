import 'package:flutter/material.dart';
import 'package:flutter_todo_list/user_interface/widgets/app/my_app.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  const app = MyApp();
  runApp(app);
}

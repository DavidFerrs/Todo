import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wl_challenge/app/core/navigation/app_routes.dart';
import 'package:wl_challenge/app/core/ui/styles/app_colors.dart';
import 'package:wl_challenge/app/modules/todo/models/todo_model.dart';
import 'package:wl_challenge/app/modules/todo/viewmodels/todo_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final rootDirectory = await getApplicationDocumentsDirectory();
  Hive.init(rootDirectory.path);
  Hive.registerAdapter(TodoAdapter());
  final todoBox = await Hive.openBox<Todo>('todoBox');
  // todoBox.deleteFromDisk();

  runApp(MyApp(
    todoBox: todoBox,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.todoBox, super.key});
  final router = AppRoutes.routes;

  final Box<Todo> todoBox;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoViewModel(todoBox),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TODO App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.blue, brightness: Brightness.light)),
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
      ),
    );
  }
}

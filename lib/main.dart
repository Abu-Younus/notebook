import 'package:flutter/material.dart';
import 'package:notebook/pages/splash_page.dart';
import 'package:notebook/viewmodel/notebook_viewmodel.dart';
import 'package:notebook/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel()),
      ChangeNotifierProvider<NotebookViewModel>(create: (context) => NotebookViewModel()),
    ],
  child: NotebookApp(),
  ),
  );
}

class NotebookApp extends StatelessWidget {
  const NotebookApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notebook',
      theme: ThemeData.light(),
      home: const SplashPage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'ui/screens/user_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..fetchUsers()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Responsivo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: UserListScreen(),
    );
  }
}

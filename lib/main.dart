import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/blocs/users/users_bloc.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => UsersBloc()..add(const GetUsersList())),
        BlocProvider(create: (context) => UsersBloc()),
      ],
      child: MaterialApp(
        title: 'BlocC Pattern - Users',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          appBarTheme: const AppBarTheme(color: Colors.blue),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

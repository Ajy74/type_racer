import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/client_state_provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';
import 'package:type_racer/screen/create_room_screen.dart';
import 'package:type_racer/screen/game_screen.dart';
import 'package:type_racer/screen/home_screen.dart';
import 'package:type_racer/screen/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> GameStateProvider()),
        ChangeNotifierProvider(create: (context)=> ClientStateProvider()),
      ],
      child: MaterialApp(
        title: 'Type Racer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => const HomeScreen(),
          '/create-room':(context) => const CreateRoomScreen(),
          '/join-room':(context) => const JoinRoomScreen(),
          '/game-screen':(context) => const GameScreen(),
        },
      ),
    );
  }
}




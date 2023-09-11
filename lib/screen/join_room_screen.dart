import 'dart:io';

import 'package:flutter/material.dart';
import 'package:type_racer/utils/socket_methods.dart';

import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.updateGameListener(context);
    _socketMethods.notCorrectGameListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Create Room',
                  style: TextStyle(fontSize: 30),
                ),

                SizedBox(height: size.height*0.08,),

                CustomTextField(controller: _nameController, hintText: "Enter your nickname"),
                const SizedBox(height: 30,),
                CustomTextField(controller: _gameIdController, hintText: "Enter Game Id"),

                const SizedBox(height: 30,),
                CustomeButtom(
                  text: 'Join', 
                  onTap: () {
                    _socketMethods.joinGame(_nameController.text, _gameIdController.text);
                  }, 
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
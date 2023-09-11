import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:type_racer/utils/socket_client.dart';
import 'package:type_racer/utils/socket_methods.dart';
import 'package:type_racer/widget/custom_button.dart';
import 'package:type_racer/widget/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
 
  final TextEditingController _nameController = TextEditingController();
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
  }

  // testing(){
  //   _socketClient.socket!.emit('test_event','This is working!');
  // }

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

                CustomTextField(
                  controller: _nameController, hintText: "Enter your nickname"
                ),

                const SizedBox(height: 30,),
                CustomeButtom(
                  text: 'Create', 
                  onTap: () {
                    // testing();             
                     _socketMethods.createGame(_nameController.text); //passing nickname to socket 
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
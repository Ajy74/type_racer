import 'package:flutter/material.dart';
import 'package:type_racer/widget/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Type Racer"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Create/Join a room to play",style: TextStyle(fontSize: 24),),
        
              SizedBox(height: size.height*0.1,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomeButtom(
                    text: "Create", 
                    onTap: () {
                      Navigator.pushNamed(context, '/create-room');
                    }, 
                    isHome: true
                  ),
                  CustomeButtom(
                    text: "Join", 
                    onTap: () {
                      Navigator.pushNamed(context, '/join-room');
                    }, 
                    isHome: true
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
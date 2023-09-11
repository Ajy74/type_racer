import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';
import 'package:type_racer/utils/socket_client.dart';
import 'package:type_racer/utils/socket_methods.dart';
import 'package:type_racer/widget/custom_button.dart';

class GameTextField extends StatefulWidget {
  const GameTextField({super.key});

  @override
  State<GameTextField> createState() => _GameTextFieldState();
}

class _GameTextFieldState extends State<GameTextField> {

  final SocketMethods _socketMethods = SocketMethods();
  late GameStateProvider? game;
  var playerMe = null;
  bool isBtn = true;

  TextEditingController _wordscontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game=Provider.of<GameStateProvider>(context,listen: false);
    findPlayerMe(game!);
  }

  handleTextChange(String value,gameID){
    //check last word or next word on the basis of space between
    var lastChar = value[value.length-1];  //to get last char

    if(lastChar == " "){
      _socketMethods.sendUserInput(value, gameID);
      setState(() {
        _wordscontroller.text = "";
      });
    }
  }
  
  findPlayerMe(GameStateProvider game){
    game.gameState['players'].forEach((player){
      if(player['socketID'] == SocketClient.instance.socket!.id){
        playerMe = player;
      }
    });
  }

  handleStart(GameStateProvider game){
    _socketMethods.startTimer(playerMe['_id'], game.gameState['id']);
    setState(() {
      isBtn = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameStateProvider>(context);
    return playerMe['isPartyLeader'] && isBtn ? CustomeButtom(
      text: 'START', 
      onTap: () {
        handleStart(gameData);
      },
    ): Container(
      child: TextFormField(
        readOnly: gameData.gameState['isJoin'],
        controller: _wordscontroller,
        onChanged: (value) {
          handleTextChange(value,gameData.gameState['id'],);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
          fillColor: const Color(0xffF5F5FA),
          hintText: "Type here",
          hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
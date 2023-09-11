import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';
import 'package:type_racer/utils/socket_methods.dart';
import 'package:type_racer/widget/scoreboard.dart';

import '../utils/socket_client.dart';

class SentenceGame extends StatefulWidget {
  const SentenceGame({super.key});

  @override
  State<SentenceGame> createState() => _SentenceGameState();
}

class _SentenceGameState extends State<SentenceGame> {
  var playerMe=null;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  findPlayerMe(GameStateProvider game){
    game.gameState['players'].forEach((player){
      if(player['socketID'] == SocketClient.instance.socket!.id){
        playerMe = player;
      }
    });
  }

  Widget getTypedWords(words,player){
    var tempWords = words.sublist(0,player['currentWordIndex']);
    String typedWord = tempWords.join(' ');
    return Text(
      typedWord,
      style: const TextStyle(
        color: Color.fromRGBO(52, 235,119, 1),
        fontSize: 30
      ),
    );
  }

  Widget getCurrentWords(words,player){
    return Text(
      words[player['currentWordIndex']],
      style: const TextStyle(
        decoration: TextDecoration.underline,
        fontSize: 30
      ),
    );
  }

  Widget getRemainingWords(words,player){
    var tempWords = words.sublist(player['currentWordIndex']+1,words.length);
    String remainingWord = tempWords.join(' ');
    return Text(
      remainingWord,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 30
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    findPlayerMe(game);

    if(game.gameState['words'].length > playerMe['currentWordIndex']){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          textDirection: TextDirection.ltr,
          children: [
            //typed words
            getTypedWords(game.gameState['words'], playerMe),

            //current word
            getCurrentWords(game.gameState['words'], playerMe),

            //words to be typed
            getRemainingWords(game.gameState['words'], playerMe),
          ],
        ),
      );
    }
    return const Scoreboard();
  }
}
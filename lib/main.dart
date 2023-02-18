import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tiktactoe/splashPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tik Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white);

  List<String> gameBoardText = ['', '', '', '', '', '', '', '', ''];
  int moveCounter = 0;
  String winner = "";
  bool playerOne = true;
  int player1Score = 0;
  int player2Score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0,154,255, 1.0),
        title: Center(
            child: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        )),
      ),
      body: Container(
        color: const Color.fromRGBO(44, 62, 80, 1.0),
        child: Column(
          children: [
            Flexible(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Tit Tac Toe",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              "Player 1",
                              style: textStyle,
                            ),
                            Text(
                              player1Score.toString(),
                              style: textStyle,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              "Player 2",
                              style: textStyle,
                            ),
                            Text(
                              player2Score.toString(),
                              style: textStyle,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tappedButton(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromRGBO(0,154,255, 1.0), width: 2)),
                      child: Center(
                          child: Text(
                        gameBoardText[index],
                        style: const TextStyle(
                            fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(241, 196, 15, 1.0),
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(
                        color: Colors.redAccent)
                  )),
                  onPressed: clearGameBoard,
                  child: const Text(
                    "Play Again",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void tappedButton(int index) {
    if (playerOne && gameBoardText[index] == '') {
      setState(() {
        gameBoardText[index] = 'X';
        moveCounter++;
      });
    } else if (!playerOne && gameBoardText[index] == '') {
      setState(() {
        gameBoardText[index] = '0';
        moveCounter++;
      });
    }
    playerOne = !playerOne;
    checkWinner();
  }

  void checkWinner() {
   if(moveCounter < 9){ 
    if (gameBoardText[0] == gameBoardText[1] &&
        gameBoardText[0] == gameBoardText[2] &&
        gameBoardText[0] != '') {
      winner = winnerChecker(gameBoardText[0]);
      showDialogBox();
    }
    if (gameBoardText[0] == gameBoardText[3] &&
        gameBoardText[0] == gameBoardText[6] &&
        gameBoardText[0] != '') {
      winner = winnerChecker(gameBoardText[0]);
      showDialogBox();
    }
    if (gameBoardText[0] == gameBoardText[4] &&
        gameBoardText[0] == gameBoardText[8] &&
        gameBoardText[0] != '') {
      winner = winnerChecker(gameBoardText[0]);
      showDialogBox();
    }
    if (gameBoardText[3] == gameBoardText[4] &&
        gameBoardText[3] == gameBoardText[5] &&
        gameBoardText[3] != '') {
      winner = winnerChecker(gameBoardText[3]);
      showDialogBox();
    }
    if (gameBoardText[6] == gameBoardText[7] &&
        gameBoardText[6] == gameBoardText[8] &&
        gameBoardText[6] != '') {
      winner = winnerChecker(gameBoardText[6]);
      showDialogBox();
    }
    if (gameBoardText[2] == gameBoardText[5] &&
        gameBoardText[2] == gameBoardText[8] &&
        gameBoardText[2] != '') {
      winner = winnerChecker(gameBoardText[2]);
      showDialogBox();
    }
    if (gameBoardText[1] == gameBoardText[4] &&
        gameBoardText[1] == gameBoardText[7] &&
        gameBoardText[1] != '') {
      winner = winnerChecker(gameBoardText[1]);
      showDialogBox();
    }
    if (gameBoardText[2] == gameBoardText[4] &&
        gameBoardText[2] == gameBoardText[6] &&
        gameBoardText[2] != '') {
      winner = winnerChecker(gameBoardText[2]);
      showDialogBox();
    }
  }else if(moveCounter == 9){
      drawChecker();
    }
  }

  void showDialogBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner is: $winner"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  clearGameBoard();
                  Navigator.of(context).pop();
                },
                child: const Text("Play Again"),
              )
            ],
          );
        });
  }

  String winnerChecker(String winnerText) {
    if (winnerText == 'X') {
      player1Score++;
      return "Player 1";
    } else {
      player2Score++;
      return "Player 2";
    }
  }

  void clearGameBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        gameBoardText[i] = '';
      }
    });
    moveCounter = 0;
  }

  void drawChecker() {
     {
      setState(() {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Draw"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      clearGameBoard();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Play Again"),
                  ),
                ],
              );
            });
      });
    }
  }
}

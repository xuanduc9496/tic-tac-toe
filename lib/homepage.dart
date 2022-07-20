import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  //const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool ohTurn = true;
  List<String> displayEx0h = ['', '', '', '', '', '', '', '', ''];

  var MytextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int exScore = 0;
  int ohScore = 0;
  int filledBoxes = 0;

  static var MyNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var MyNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Player O',
                        style: MyNewFontWhite,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        ohScore.toString(),
                        style: MyNewFontWhite,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Player X',
                        style: MyNewFontWhite,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        exScore.toString(),
                        style: MyNewFontWhite,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                          child: Text(
                        //index.toString(),
                        displayEx0h[index],
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TIC TAC TOE',
                      style: MyNewFontWhite,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text('@CREATE BY XUANDUC', style: MyNewFontWhite)
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    filledBoxes += 1;

    setState(() {
      if (ohTurn && displayEx0h[index] == '') {
        displayEx0h[index] = 'o';
      } else if (!ohTurn && displayEx0h[index] == '') {
        displayEx0h[index] = 'x';
      }

      ohTurn = !ohTurn;
      _checkwinner();
    });
  }

  void _checkwinner() {
    if (displayEx0h[0] == displayEx0h[1] &&
        displayEx0h[0] == displayEx0h[2] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }
    if (displayEx0h[3] == displayEx0h[4] &&
        displayEx0h[3] == displayEx0h[5] &&
        displayEx0h[3] != '') {
      _showWinDialog(displayEx0h[3]);
    }
    if (displayEx0h[6] == displayEx0h[7] &&
        displayEx0h[6] == displayEx0h[8] &&
        displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }
    if (displayEx0h[0] == displayEx0h[3] &&
        displayEx0h[0] == displayEx0h[6] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }
    if (displayEx0h[1] == displayEx0h[4] &&
        displayEx0h[1] == displayEx0h[7] &&
        displayEx0h[1] != '') {
      _showWinDialog(displayEx0h[1]);
    }
    if (displayEx0h[2] == displayEx0h[5] &&
        displayEx0h[2] == displayEx0h[8] &&
        displayEx0h[2] != '') {
      _showWinDialog(displayEx0h[2]);
    }
    if (displayEx0h[6] == displayEx0h[4] &&
        displayEx0h[6] == displayEx0h[2] &&
        displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }
    if (displayEx0h[0] == displayEx0h[4] &&
        displayEx0h[0] == displayEx0h[8] &&
        displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('O & X Draw!'),
            actions: [
              FlatButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again!'))
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner is: ' + winner),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again!'),
              ),
            ],
          );
        });
    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayEx0h[i] = '';
      }
    });
    filledBoxes = 0;
  }
}

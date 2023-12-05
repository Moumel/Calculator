import 'package:calculator/calculatorbuttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userQ = '';
  var userA = '';

  final List<String> button = [
    'c', '/', 'x', 'D',
    '7', '8', '9', '-',
    '4', '5', '6', '+',
    '1', '2', '3', 'A',
    '%', '0', '.', '=',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft, child: Text(userQ, style: TextStyle(fontSize: 25, color: Colors.white),),),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight, child: Text(userA, style: TextStyle(fontSize: 25, color: Colors.white),),)
                ],
              ),
            ),),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: button.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Cbuttons(
                        buttonTap: () {
                          setState(() {
                            userQ = '';
                            userA = '';
                          });
                        },
                        button: button[index],
                        textColor: Colors.white,
                        color: Colors.red,
                      );
                    }
                    else if (index == 3) {
                      return Cbuttons(
                        buttonTap: (){
                          setState(() {
                            userQ = userQ.substring(0, userQ.length-1);
                          });
                        },
                        button: button[index],
                        color: Colors.blueGrey,
                      );
                    }
                    else if (index == 19) {
                      return Cbuttons(
                        buttonTap: (){
                          setState(() {
                            epress();
                          });
                        },
                        button: button[index],
                        color: Colors.blueGrey,
                      );
                    }
                    else {
                      return Cbuttons(
                        buttonTap: () {
                          setState(() {
                            userQ += button[index];
                          });
                        },
                        button: button[index],
                        color: isOperator(button[index])
                            ? Colors.blueGrey
                            : Colors.white30,
                        textColor: isOperator(button[index])
                            ? Colors.blue[80]
                            : Colors.white,
                      );
                    }
                  }
              ),
            ),),

        ],
      ),

    );
  }
  bool isOperator(String x ){
    if (x=='c' || x =='/' || x=='x' || x =='D' || x=='-' || x =='+' || x=='A' || x =='=' ) {
      return true;
    }
    return false;
  }

  void epress () {
    String finalq = userQ;
    finalq = finalq.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalq);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userA = eval.toString();

  }
}

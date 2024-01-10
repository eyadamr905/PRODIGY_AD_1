import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> symbols = [
    'AC',
    'Del',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '.',
    '0',
    'Ans',
    '=',
  ];//all numbers and symbols for calc
  String input = '';
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(128, 41, 32, 32),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                input,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 232, 232, 232)),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                output,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 251, 251, 251)),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: symbols.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (symbols[index] == 'AC') {
                      setState(() {
                        input = '';
                        output = '';//clear every thing
                      });
                    } else if (symbols[index] == 'Del') {
                      setState(() {
                        input = substring();//call methode
                      });
                    } else if (symbols[index] == 'Ans') {
                      setState(() {
                        input = output;
                        output = '';//replace outpot to inpot
                      });
                    } else if (symbols[index] == '%' ||
                        symbols[index] == '/' ||
                        symbols[index] == '*' ||
                        symbols[index] == '+' ||
                        symbols[index] == '-') {
                      if (input.endsWith("%") ||
                          input.endsWith("*") ||
                          input.endsWith("/") ||
                          input.endsWith("+") ||
                          input.endsWith("-")) {
                        //
                      } else {
                        setState(() {
                          input += symbols[index];
                        });
                      }
                    } else if (symbols[index] == '=') {
                      Expression exp = parse();
                      double result = evaluate(exp);
                      setState(() {
                        output = result.toString();
                      });

                      //output
                    } else {
                      setState(() {
                        input += symbols[index];
                      });
                    }
                    //logic
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: myBackgroundColor(symbols[index]),
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: Text(
                      symbols[index],
                      style: TextStyle(
                        color: myTextColor(symbols[index]),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  evaluate(Expression exp) => exp.evaluate(EvaluationType.REAL, ContextModel());

  String substring() => input.substring(0, input.length - 1);

  Expression parse() => Parser().parse(input);

  Color myBackgroundColor(String x) {
    if (x == 'AC') {
      return const Color.fromARGB(255, 249, 159, 15);
    } else if (x == 'Del') {
      return const Color.fromARGB(255, 225, 112, 19);
    } else if (x == '%' ||
        x == '/' ||
        x == '+' ||
        x == '*' ||
        x == '-' ||
        x == '=') {
      return const Color.fromARGB(255, 225, 112, 19);
    } else {
      return const Color.fromARGB(255, 141, 137, 137);
    }
  }

  Color myTextColor(String x) {
    if (x == '%' ||
        x == 'Del' ||
        x == '/' ||
        x == '+' ||
        x == '*' ||
        x == '-' ||
        x == '=') {
      return const Color.fromARGB(255, 0, 0, 0);
    } else {
      return const Color.fromARGB(255, 0, 0, 0);
    }
  }
}

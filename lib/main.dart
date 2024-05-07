import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const DiceRollerPage(),
    );
  }
}

class DiceRollerPage extends StatefulWidget {
  const DiceRollerPage({super.key});

  @override
  State<DiceRollerPage> createState() => _DiceRollerPageState();
}

class _DiceRollerPageState extends State<DiceRollerPage> {
  int? dice;
  Timer? timer;

  void rollDice() {
    // setState(() {
    //   dice = null;
    // });

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        dice = Random().nextInt(6) + 1;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      timer?.cancel();
      setState(() {
        dice = Random().nextInt(6) + 1;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Roller'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
          child: dice == null
              ? const Text('Press the button to roll the dice',
                  style: TextStyle(fontSize: 24.0))
              : SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/dice-$dice.png'))),
      floatingActionButton: FloatingActionButton(
        onPressed: rollDice,
        child: const Icon(Icons.roller_shades),
      ),
    );
  }
}

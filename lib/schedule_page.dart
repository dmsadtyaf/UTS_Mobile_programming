import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text("Jadwal latihan kamu"),
      ),
    );
  }
}
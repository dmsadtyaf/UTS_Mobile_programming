import 'package:flutter/material.dart';
import 'workout_detail_page.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> statusWorkout = {
    'Push Up': false,
    'Bench Press': false,
    'Chin Up': false,
    'Lari di Tempat': false,
    'Jumping Jack': false,
    'Jalan di Tempat': false,
    'Stretching 10 Menit': false,
  };

  double getProgress() {
    int done = statusWorkout.values.where((e) => e).length;
    return done / statusWorkout.length;
  }

  @override
  Widget build(BuildContext context) {
    double progress = getProgress();

    return Scaffold(
      appBar: AppBar(title: Text("Halo ${widget.username}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("${(progress * 100).toInt()}%"),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  statusWorkout.updateAll((key, value) => false);
                });
              },
              child: const Text("Reset"),
            ),
            const SizedBox(height: 20),
            menuCard("Main Training", Icons.fitness_center,
                ["Push Up", "Bench Press", "Chin Up"]),
            menuCard("Cardio", Icons.directions_run,
                ["Lari di Tempat", "Jumping Jack", "Jalan di Tempat"]),
            menuCard("Stretching", Icons.self_improvement,
                ["Stretching 10 Menit"]),
          ],
        ),
      ),
    );
  }

  Widget menuCard(String title, IconData icon, List<String> workouts) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WorkoutDetailPage(
                title: title,
                workouts: workouts,
                statusMap: statusWorkout,
              ),
            ),
          );

          if (result != null) {
            setState(() {
              statusWorkout = result;
            });
          }
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatefulWidget {
  final String title;
  final List<String> workouts;
  final Map<String, bool> statusMap;

  const WorkoutDetailPage({
    super.key,
    required this.title,
    required this.workouts,
    required this.statusMap,
  });

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  late Map<String, bool> localStatus;

  @override
  void initState() {
    super.initState();
    localStatus = Map.from(widget.statusMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: widget.workouts.length,
        itemBuilder: (context, index) {
          String item = widget.workouts[index];

          return ListTile(
            title: Text(item),
            trailing: Icon(
              Icons.check_circle,
              color: localStatus[item]! ? Colors.green : Colors.grey,
            ),
            onTap: () {
              setState(() {
                localStatus[item] = !localStatus[item]!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, localStatus);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
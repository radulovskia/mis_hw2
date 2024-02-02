import "package:flutter/material.dart";

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String sets;
  final String reps;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.sets,
    required this.reps,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          children: [
            Chip(label: Text("${weight}kg")),
            Chip(label: Text("${sets}sets")),
            Chip(label: Text("${reps}reps")),
          ],
        ),
        trailing: Checkbox(value: isCompleted,
          onChanged: (value) => onCheckBoxChanged!(value)),
      ),
    );
  }
}

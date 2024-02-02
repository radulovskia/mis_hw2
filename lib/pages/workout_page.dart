import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hw2/components/exercise_tile.dart';
import 'package:provider/provider.dart';

import '../data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .completeExercise(workoutName, exerciseName);
  }

  final exerciseNameController = TextEditingController();
  final exerciseWeightController = TextEditingController();
  final exerciseRepsController = TextEditingController();
  final exerciseSetsController = TextEditingController();

  void createNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add a new exercise"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: exerciseNameController,
                  ),
                  TextField(
                    controller: exerciseWeightController,
                  ),
                  TextField(
                    controller: exerciseRepsController,
                  ),
                  TextField(
                    controller: exerciseSetsController,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text("Save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: Text("Cancel"),
                ),
              ],
            ));
  }

  void save() {
    String exerciseName = exerciseNameController.text;
    String exerciseWeight = exerciseWeightController.text;
    String exerciseReps = exerciseRepsController.text;
    String exerciseSets = exerciseSetsController.text;
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      exerciseName,
      exerciseWeight,
      exerciseReps,
      exerciseSets,
    );
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    exerciseWeightController.clear();
    exerciseRepsController.clear();
    exerciseSetsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(title: Text(widget.workoutName)),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: createNewExercise,
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
              exerciseName: value
                  .findWorkoutByName(widget.workoutName)
                  .exercises[index]
                  .name,
              weight: value
                  .findWorkoutByName(widget.workoutName)
                  .exercises[index]
                  .weight,
              sets: value
                  .findWorkoutByName(widget.workoutName)
                  .exercises[index]
                  .sets,
              reps: value
                  .findWorkoutByName(widget.workoutName)
                  .exercises[index]
                  .reps,
              isCompleted: value
                  .findWorkoutByName(widget.workoutName)
                  .exercises[index]
                  .isCompleted,
              onCheckBoxChanged: (val) => onCheckBoxChanged(
                  widget.workoutName,
                  value
                      .findWorkoutByName(widget.workoutName)
                      .exercises[index]
                      .name)),
        ),
      ),
    );
  }
}

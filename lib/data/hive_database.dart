import 'package:hive_flutter/hive_flutter.dart';
import 'package:hw2/datetime/date_time.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class HiveDatabase {
  final _myBox = Hive.box("workout_db");

  bool previousDataExists() {
    final dts = DateTimeService();
    if (_myBox.isEmpty) {
      print("previous data does NOT exist");
      _myBox.put("START_DATE", dts.todaysDateYYYYMMDD());
      return false;
    } else {
      print("previous data DOES exist");
      return true;
    }
  }

  String getStartDate() {
    return _myBox.get("START_DATE");
  }

  int exerciseCompleted(List<Workout> workouts) {
    int count = 0;
    for (var w in workouts) {
      for (var e in w.exercises) {
        if (e.isCompleted) {
          count += 1;
        }
      }
    }
    return count;
  }

  void saveToDatabase(List<Workout> workouts) {
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);
    final dts = DateTimeService();

    _myBox.put("COMPLETION_STATUS_${dts.todaysDateYYYYMMDD()}", exerciseCompleted(workouts));

    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];
    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exercisesInEachWorkout = [];

      for (int j = 0; j < exerciseDetails[i].length; j++) {
        Exercise e = Exercise(
            name: exerciseDetails[i][j][0],
            weight: exerciseDetails[i][j][1],
            reps: exerciseDetails[i][j][2],
            sets: exerciseDetails[i][j][3]);
        exerciseDetails[i][j][4] == "true"
            ? e.isCompleted = true
            : e.isCompleted = false;
        exercisesInEachWorkout.add(e);
      }

      Workout w =
          Workout(name: workoutNames[i], exercises: exercisesInEachWorkout);
      mySavedWorkouts.add(w);
    }

    return mySavedWorkouts;
  }

  int getCompletedStatus(String yyyymmdd) {
    return _myBox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
  }
}

List<String> convertObjectToWorkoutList(List<Workout> workouts) {
  List<String> workoutList = [];

  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(workouts[i].name);
  }

  return workoutList;
}

List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];

  for (int i = 0; i < workouts.length; i++) {
    List<Exercise> exercisesInWorkout = workouts[i].exercises;
    List<List<String>> individualWorkout = [];

    for (int j = 0; j < exercisesInWorkout.length; j++) {
      List<String> individualExercise = [];

      individualExercise.addAll([
        exercisesInWorkout[j].name,
        exercisesInWorkout[j].weight,
        exercisesInWorkout[j].reps,
        exercisesInWorkout[j].sets,
        exercisesInWorkout[j].isCompleted.toString(),
      ]);
      individualWorkout.add(individualExercise);
    }

    exerciseList.add(individualWorkout);
  }
  return exerciseList;
}

import 'package:flutter/material.dart';
import 'package:hw2/models/exercise.dart';

import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    // some default workout
    Workout(name: "Full Body", exercises: [
      Exercise(name: "Bench Press", weight: "80", reps: "10", sets: "3"),
      Exercise(name: "Barbell Rows", weight: "70", reps: "10", sets: "3"),
      Exercise(name: "Wide Pulldowns", weight: "60", reps: "8", sets: "3"),
      Exercise(name: "Overhead Press", weight: "50", reps: "8", sets: "3"),
      Exercise(name: "Leg Press", weight: "120", reps: "10", sets: "4"),
      Exercise(name: "Bicep Curls", weight: "40", reps: "12", sets: "3"),
      Exercise(name: "Lateral Raises", weight: "15", reps: "15", sets: "3"),
    ])
  ];
  Workout findWorkoutByName(String name){
    return workoutList.firstWhere((w) => w.name == name);
  }

  Exercise findExerciseInWorkoutByNames(String workoutName, String exerciseName){
    Workout w = findWorkoutByName(workoutName);
    return w.exercises.firstWhere((e) => e.name == exerciseName);
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfExercisesInWorkout(String workoutName){
    Workout w = findWorkoutByName(workoutName);
    return w.exercises.length;
  }

  void addWorkout(String name){
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
  }

  void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets){
    Workout w = findWorkoutByName(workoutName);
    w.exercises.add(Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));
    notifyListeners();
  }

  void completeExercise(String workoutName, String exerciseName){
    Exercise e = findExerciseInWorkoutByNames(workoutName, exerciseName);
    e.isCompleted = !e.isCompleted;
    notifyListeners();
  }
}
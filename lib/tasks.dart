//Tasks Data Structure Class

import 'package:task_tracker_app/data_manager.dart';
import 'package:uuid/uuid.dart';

class Step {
  int no;
  String content;
  String comment;
  int status;

  Step({
    required this.no,
    required this.content,
    required this.comment,
    required this.status
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      no: json['no'],
      content: json['content'],
      comment: json['comment'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'content': content,
      'comment': comment,
      'status': status 
    };
  }
}

class Task {
  String taskName;
  String description;
  int currentStep;
  int status;
  List<Step> steps;
  bool archived;
  String id;

 static String generateRandomString() {
  final Uuid uuid = Uuid();
  return uuid.v4();
}

static Task fetchTaskWithId(String id) {
    for(Task task in DataManager.data) {
      if( task.id == id) {
        return task;
      }
    }
    return Task(taskName: "", description: "", currentStep: 0, status: 1, steps: [], id: Task.generateRandomString(), archived: false);
  }

  Task({
    required this.taskName,
    required this.description,
    required this.currentStep,
    required this.status,
    required this.steps,
    required this.id,
    this.archived = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    var stepsList = json['steps'] as List;
    List<Step> steps = stepsList.map((i) => Step.fromJson(i)).toList();

    return Task(
      taskName: json['task_name'],
      description: json['description'],
      currentStep: json['current_step'],
      status: json['status'],
      steps: steps,
      archived: json['archived'],
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_name': taskName,
      'description': description,
      'current_step': currentStep,
      'status': status,
      'steps': steps.map((step) => step.toJson()).toList(),
      'archived': archived,
      'id': id
    };
  }

}
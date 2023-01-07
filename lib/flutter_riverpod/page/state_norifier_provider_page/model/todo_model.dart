import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Todo extends Equatable {
  int id;
  bool completed;
  String description;

  @override
  List<Object> get props => [id, completed, description];

  Todo({
    @required this.id,
    @required this.completed,
    @required this.description,
  });

  @override
  String toString() {
    return 'Todo{' + ' id: $id,' + ' completed: $completed,' + ' description: $description,' + '}';
  }

  Todo copyWith({
    int id,
    bool completed,
    String description,
  }) {
    return Todo(
      id: id ?? this.id,
      completed: completed ?? this.completed,
      description: description ?? this.description,
    );
  }
}

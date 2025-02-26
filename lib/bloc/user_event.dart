import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {}

class AddUser extends UserEvent {
  final String name;
  final String age;
  final String location;

  AddUser({required this.name, required this.age, required this.location});

  @override
  List<Object> get props => [name, age, location];
}

class UpdateUser extends UserEvent {
  final String id;
  final String name;
  final String age;
  final String location;

  UpdateUser({required this.id, required this.name, required this.age, required this.location});

  @override
  List<Object> get props => [id, name, age, location];
}

class DeleteUser extends UserEvent {
  final String id;

  DeleteUser({required this.id});

  @override
  List<Object> get props => [id];
}

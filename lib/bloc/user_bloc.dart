// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task/bloc/user_event.dart';
// import 'package:task/bloc/user_state.dart';
// import 'package:task/service/database.dart';
// import 'package:task/model/usermodel.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final DatabaseMethods databaseMethods;

//   UserBloc({required this.databaseMethods}) : super(UserLoading()) {
//     on<FetchUsers>(_onFetchUsers);
//     on<AddUser>(_onAddUser);
//     on<UpdateUser>(_onUpdateUser);
//     on<DeleteUser>(_onDeleteUser);
//   }

//   void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
//     try {
//       // List<User> users = await databaseMethods.getAllLocalUsers();
//       emit(UserLoaded(users: users));
//     } catch (e) {
//       emit(UserError(message: "Failed to fetch users"));
//     }
//   }

//   void _onAddUser(AddUser event, Emitter<UserState> emit) async {
//     try {
//       await databaseMethods.addUserDetails({
//         "Name": event.name,
//         "Age": event.age,
//         "Location": event.location
//       }, event.name);
      
//       add(FetchUsers());
//     } catch (e) {
//       emit(UserError(message: "Failed to add user"));
//     }
//   }

//   void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
//     try {
//       await databaseMethods.updateUserDetail(event.id, {
//         "Name": event.name,
//         "Age": event.age,
//         "Location": event.location
//       });

//       add(FetchUsers());
//     } catch (e) {
//       emit(UserError(message: "Failed to update user"));
//     }
//   }

//   void _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
//     try {
//       await databaseMethods.deleteUser(event.id);

//       add(FetchUsers());
//     } catch (e) {
//       emit(UserError(message: "Failed to delete user"));
//     }
//   }
// }

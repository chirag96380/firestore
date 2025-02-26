import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:task/model/usermodel.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userDetailMap, String id) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userDetailMap);

    var userBox = Hive.box<User>('users');
    User newUser = User(
      id: id,
      name: userDetailMap["Name"],
      age: userDetailMap["Age"],
      location: userDetailMap["Location"],
    );
    userBox.put(id, newUser);
  }

  List<User> getOfflineUsers() {
    var userBox = Hive.box<User>('users');
    return userBox.values.toList();
  }

  Future<void> deleteUser(String id) async {
    await FirebaseFirestore.instance.collection("User").doc(id).delete();
    var userBox = Hive.box<User>('users');
    userBox.delete(id);
  }

  Future<Stream<QuerySnapshot>> getUserDetails() async {
    return FirebaseFirestore.instance.collection("User").snapshots();
  }

  Future<void> updateUserDetail(
      String id, Map<String, dynamic> userDetailMap) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userDetailMap, SetOptions(merge: true));
  }

  Future<void> updateDetelDetail(
    String id,
  ) async {
    await FirebaseFirestore.instance.collection("User").doc(id).delete();
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:hive/hive.dart';
// import 'package:task/model/usermodel.dart';

// class DatabaseMethods {
//   final Box<User> userBox = Hive.box<User>('users');

  
//   Future<void> addUserDetails(
//       Map<String, dynamic> userDetailMap, String id) async {
//     User user = User(
//       id: id,
//       name: userDetailMap["Name"],
//       age: userDetailMap["Age"],
//       location: userDetailMap["Location"],
//     );

//     await userBox.put(id, user);
//     await syncLocalDataToFirebase();
//   }

//   Future<Stream<QuerySnapshot>> getUserDetails() async {
//     return FirebaseFirestore.instance.collection("User").snapshots();
//   }
//   Future<void> updateUserDetail(
//       String id, Map<String, dynamic> userDetailMap) async {
//     User updatedUser = User(
//       id: id,
//       name: userDetailMap["Name"],
//       age: userDetailMap["Age"],
//       location: userDetailMap["Location"],
//     );

//     // Hive me update karo.
//     await userBox.put(id, updatedUser);

//     // Sync local changes to Firebase.
//     await syncLocalDataToFirebase();
//   }

//   // Delete user: Hive se delete karo aur Firebase se bhi delete karo.
//   Future<void> deleteUser(String id) async {
//     // Delete local Hive data.
//     await userBox.delete(id);

//     // Delete from Firebase.
//     await FirebaseFirestore.instance.collection("User").doc(id).delete();
//   }

//   // Sync local Hive data to Firebase if internet is available.
//   Future<void> syncLocalDataToFirebase() async {
//     // Connectivity check: Yahan aap connectivity_plus package ka use kar sakte hain.
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult != ConnectivityResult.none) {
//       // For each user stored locally, sync with Firebase.
//       for (var user in userBox.values) {
//         Map<String, dynamic> userMap = {
//           "Name": user.name,
//           "Age": user.age,
//           "id": user.id,
//           "Location": user.location,
//         };

//         // Firebase me sync karo.
//         await FirebaseFirestore.instance
//             .collection("User")
//             .doc(user.id)
//             .set(userMap, SetOptions(merge: true));

//         // Sync hone ke baad Hive se remove karo.
//         await userBox.delete(user.id);
//       }
//     }
//   }
// }

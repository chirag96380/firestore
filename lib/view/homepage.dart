// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/service/database.dart';
import 'package:task/view/add_user_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locController = TextEditingController();

  Stream? UserStream;

  loadData() async {
    UserStream = await DatabaseMethods().getUserDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget AllUserDetails() {
    return StreamBuilder(
        stream: UserStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Material(
                      elevation: 5.0,
                      child: Container(
                        margin: EdgeInsets.all(12.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: const Color.fromARGB(255, 254, 144, 19),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name: ${ds["Name"]}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        nameController.text = ds["Name"];
                                        ageController.text = ds["Age"];
                                        locController.text = ds["Location"];
                                        EditUserDetail(ds["id"]);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    12.horizontalSpace,
                                    GestureDetector(
                                      onTap: () async {
                                        await DatabaseMethods()
                                            .deleteUser(ds["id"]);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Text(
                              "Age: ${ds["Age"]}",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Location: ${ds["Location"]}",
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (contex) => AddUserDetail()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              "Prectical ",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            Text(
              "Task ",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          children: [Expanded(child: AllUserDetails())],
        ),
      ),
    );
  }

  Future EditUserDetail(String id) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update user Details"),
            content: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    const Text(
                      "Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    12.verticalSpace,
                    Container(
                      margin: EdgeInsets.only(left: 12.w, right: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    20.verticalSpace,
                    // second field

                    const Text(
                      "Age",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    12.verticalSpace,
                    Container(
                      margin: EdgeInsets.only(left: 12.w, right: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: ageController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    20.verticalSpace,
                    // third field
                    const Text(
                      "Location",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    12.verticalSpace,
                    Container(
                      margin: EdgeInsets.only(left: 12.w, right: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: locController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    )
                  ]),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Map<String, dynamic> UserUpdate = {
                    "Name": nameController.text,
                    "Age": ageController.text,
                    "id": id,
                    "Location": locController.text
                  };
                  await DatabaseMethods()
                      .updateUserDetail(id, UserUpdate)
                      // ignore: use_build_context_synchronously
                      .then((e) => Navigator.of(context).pop());
                },
                child: const Text("Update"),
              ),
            ],
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_string/random_string.dart';
import 'package:task/service/database.dart';
import 'package:task/service/notification/noti.dart';

class AddUserDetail extends StatefulWidget {
  const AddUserDetail({super.key});

  @override
  State<AddUserDetail> createState() => _AddUserDetailState();
}

class _AddUserDetailState extends State<AddUserDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add List"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              "Name",
            ),
            12.verticalSpace,
            Container(
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

            Text(
              "Age",
            ),
            12.verticalSpace,
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: ageController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            20.verticalSpace,
            // third field
            Text(
              "Location",
            ),
            12.verticalSpace,
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: locController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            12.verticalSpace,
            ElevatedButton(
                onPressed: () async {
                  // ignore: non_constant_identifier_names
                  String Id = randomAlphaNumeric(10);
                  Map<String, dynamic> userDetailMap = {
                    "Name": nameController.text,
                    "Age": ageController.text,
                    "id": Id,
                    "Location": locController.text
                  };
                  await DatabaseMethods()
                      .addUserDetails(userDetailMap, Id)
                      .then((e) => NotificationService().showNotification(
                          body: "User added successfully.",
                          title: "User Detail"));
                },
                child: Text("Add"))
          ],
        ),
      ),
    );
  }
}

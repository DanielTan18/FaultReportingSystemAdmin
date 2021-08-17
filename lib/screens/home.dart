import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_admin/helpers/screen_navigation.dart';
import 'package:fyp_admin/providers/app.dart';
import 'package:fyp_admin/providers/user.dart';
import 'package:fyp_admin/screens/view_reports.dart';
import 'package:fyp_admin/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    Map data;
    final databaseReference = Firestore.instance;

    // databaseReference
    //     .collection("faulttype")
    //     .getDocuments()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.documents.forEach((f) => print('BRO ${f.data}'));
    // });

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Welcome, ADMIN " + user.userModel?.name + "!"),
      ),
      body: ListView(children: [
        SizedBox(
          height: 250,
        ),
        Center(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    icon: Icon(
                      Icons.view_headline_rounded,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("ADMIN View Reports"),
                  ),
                  onPressed: () {
                    changeScreen(context, ViewReportsScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

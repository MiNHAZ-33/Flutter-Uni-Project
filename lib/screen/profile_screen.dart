import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/login_page.dart';
import 'package:project/screen/timer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF252634),
        elevation: 5,
        actions: [
          TextButton(
            child: const Text(
              "LogOut",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
              });
            },
          ),
        ],
        title: const Text("Profile"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image.asset('assets/images/daffodil.png', height: 100, width: 100),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 5),
                        color: Colors.deepOrange.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10)
                  ]),
              child: const Text(
                'Personal Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  // fontFamily: 'Montserrat',
                  // fontStyle: FontStyle.italic')
                ),
              ),
            ),
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', 'Mariam Binta Mim', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemProfile('Student ID', ' 203-51-028', CupertinoIcons.person),
            const SizedBox(height: 10),
            itemProfile('Department', 'ITM', CupertinoIcons.phone),
            const SizedBox(height: 10),
            itemProfile('Blood Group', 'B+', CupertinoIcons.mail),
            const SizedBox(height: 10),
            itemProfile('Course Title', 'Mobile Application Development',
                CupertinoIcons.mail),
            const SizedBox(
              height: 20,
            ),
            const TimerWidget(),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.deepOrange.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        // leading: Icon(iconData),
        // trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}

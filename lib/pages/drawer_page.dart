import 'package:flutter/material.dart';
import 'package:notebook/pages/login_page.dart';
import 'package:notebook/sharedpref/shared_pref.dart';
import 'package:notebook/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (_, userViewModel, ___) {
      return Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 2,
                          ),
                          image: DecorationImage(
                              image: AssetImage('assets/images/img.jpg'),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                      SizedBox(height: 1,),
                      Text(
                        userViewModel.userData.name ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        userViewModel.userData.email ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                    ],
                  )),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  PreferenceManagement.clearPreference();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          ),
        ),
      );
    });
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notebook/pages/login_page.dart';
import 'package:notebook/sharedpref/shared_pref.dart';
import 'package:notebook/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    initSharePreference();
  }

  initSharePreference() async {
    await PreferenceManagement.init();
    redirectToHomePage();
  }

  void redirectToHomePage() {
    Timer(const Duration(seconds: 2), () {
      if(PreferenceManagement.getIsLoggedIn() != null && PreferenceManagement.getIsLoggedIn() == true) {
        UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
        userViewModel.getUserById(context);
      }
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notebook',
              style: TextStyle(
                fontSize: 38,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 200,
              height: 3,
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

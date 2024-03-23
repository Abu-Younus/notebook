import 'package:flutter/material.dart';
import 'package:notebook/models/user_model.dart';
import 'package:notebook/pages/home_page.dart';
import 'package:notebook/repository/user_repository.dart';
import 'package:notebook/sharedpref/shared_pref.dart';

class UserViewModel extends ChangeNotifier{
  final UserRepository userRepository = UserRepository();
  TextEditingController nameTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController passwordTxtController = TextEditingController();
  TextEditingController confirmPassTxtController = TextEditingController();
  UserModel userData = UserModel();
  bool? isLoading;

  void validateRegistrationForm(BuildContext mContext) async{
    if(nameTxtController.text.isEmpty) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(content: Text('Name is required')),
      );
    }
    else if(emailTxtController.text.isEmpty) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(content: Text('Email is required')),
      );
    }
    else if(passwordTxtController.text.isEmpty) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(content: Text('Password is required')),
      );
    }
    else if(confirmPassTxtController.text != passwordTxtController.text) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(content: Text('Password doesn\'t matched!')),
      );
    }
    else {
      bool isUserExist = await userRepository.isUserExistRepo(emailTxtController.text);
      if(isUserExist == true) {
        ScaffoldMessenger.of(mContext).showSnackBar(
          SnackBar(content: Text('${emailTxtController.text} is already exist!')),
        );
      }
      else {
        UserModel userModel = UserModel(
            name: nameTxtController.text,
            email: emailTxtController.text,
            password: passwordTxtController.text);
        int isRegister = await userRepository.registerUserRepo(userModel);
        if (isRegister > 0) {
          ScaffoldMessenger.of(mContext).showSnackBar(
            SnackBar(
              content: Text(
                  '${emailTxtController.text} successfully registered'),
            ),
          );
          Navigator.pop(mContext);
        }
      }
    }
  }

  void validateLoginForm(BuildContext mContext) async {
    if (emailTxtController.text.isEmpty) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(
          content: Text('Email is required'),
        ),
      );
    }
    else if (passwordTxtController.text.isEmpty) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(
          content: Text('Password is required'),
        ),
      );
    }
    else {
      UserModel userModel =
      await userRepository.fetchUserByEmailAndPasswordRepo(
          emailTxtController.text, passwordTxtController.text);

      if (userModel.id != null) {
        userData = userModel;
        PreferenceManagement.setIsLoggedIn(true);
        PreferenceManagement.setUserId(userData.id!);
        Navigator.push(
            mContext, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(mContext).showSnackBar(
          const SnackBar(
            content: Text('Credential mismatch'),
          ),
        );
      }
    }
  }

  void getUserById(BuildContext mContext) async{
    UserModel userModel = await userRepository.fetchUserByIdRepo(PreferenceManagement.getUserId() ?? 0);
    if (userModel.id != null) {
      userData = userModel;
      Navigator.push(
          mContext, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  void resetRegisterPage() {
    nameTxtController.clear();
    emailTxtController.clear();
    passwordTxtController.clear();
    confirmPassTxtController.clear();
  }
}
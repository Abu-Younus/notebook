import 'package:notebook/database/database_management.dart';
import 'package:notebook/models/user_model.dart';

class UserRepository{
  final DatabaseManager db = DatabaseManager();

  Future<int> registerUserRepo(UserModel user) async{
    return await db.registerUser(user);
  }

  Future<bool> isUserExistRepo(String email) async{
    return await db.isUserExist(email);
  }

  Future<UserModel> fetchUserByIdRepo(int id) async{
    return await db.fetchUserById(id);
  }

  Future<UserModel> fetchUserByEmailAndPasswordRepo(String email, String password) async{
    return await db.fetchUserByEmailAndPassword(email, password);
  }
}
import 'package:mood_journal/domain/models/user/user.dart';
import 'package:mood_journal/domain/repository/base_repo.dart';

abstract class UserRepo extends BaseRepo {
  Future<User> getUser({required String userId});
  Future<void> deleteUser(String userId);
  Future<void> updateUser(String id, UserBody user);
  Future<void> createUser(UserBody user);
}

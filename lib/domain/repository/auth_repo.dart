import 'package:mood_journal/domain/models/user/user.dart';
import 'package:mood_journal/domain/repository/base_repo.dart';

abstract class AuthRepo extends BaseRepo {
  Future<bool> isSignedIn();
  Future<User> getUser();
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mood_journal/data/models/user/user.dart' as u;

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    required final String id,
    required final String name,
  }) = _User;

  factory User.fromLSUser(u.User from) {
    return User(
      id: from.id,
      name: from.name,
    );
  }
}

extension XUser on User {
  u.User get toLSUser {
    return u.User(
      id: id,
      name: name,
    );
  }
}

@freezed
class UserBody with _$UserBody {
  const UserBody._();
  const factory UserBody({
    required final String name,
  }) = _UserBody;

  factory UserBody.fromLSUserBody(u.UserBody from) {
    return UserBody(
      name: from.name,
    );
  }

  factory UserBody.initial() => const UserBody(
        name: '',
      );

  factory UserBody.fromUser(User user) => UserBody(
        name: user.name,
      );

  factory UserBody.fromLSUser(u.User user) => UserBody(
        name: user.name,
      );
}

extension XUserBody on UserBody {
  u.UserBody get toLSUserBody {
    return u.UserBody(
      name: name,
    );
  }
}

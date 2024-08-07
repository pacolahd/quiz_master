import 'package:pacola_quiz/core/enums/update_enums.dart';
import 'package:pacola_quiz/core/utils/typedefs.dart';
import 'package:pacola_quiz/src/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<UserEntity> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
  ResultFuture<UserEntity> signInWithGoogle();
}

part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent {}

class SendResetEmail extends ResetPasswordEvent {
  final String email;
  SendResetEmail(this.email);
}

class VerifyResetCode extends ResetPasswordEvent {
  final String code;
  VerifyResetCode(this.code);
}

class ResetPasswordWithEmailCode extends ResetPasswordEvent {
  final String email;
  final String code;
  ResetPasswordWithEmailCode({required this.email, required this.code});
}

import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddDigit extends PasswordEvent {
  final int digit;

  AddDigit(this.digit);

  @override
  List<Object> get props => [digit];
}

class RemoveDigit extends PasswordEvent {}

class SubmitPassword extends PasswordEvent {}

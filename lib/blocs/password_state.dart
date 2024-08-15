import 'package:equatable/equatable.dart';

class PasswordState extends Equatable {
  final List<int> pin;
  final bool isSubmitted;
  final bool isValid;

  const PasswordState({
    this.pin = const [],
    this.isSubmitted = false,
    this.isValid = false,
  });

  PasswordState copyWith({
    List<int>? pin,
    bool? isSubmitted,
    bool? isValid,
  }) {
    return PasswordState(
      pin: pin ?? this.pin,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [pin, isSubmitted, isValid];
}

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_95/blocs/password_event.dart';
import 'package:lesson_95/blocs/password_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordState()) {
    on<AddDigit>(_onAddDigit);
    on<RemoveDigit>(_onRemoveDigit);
    on<SubmitPassword>(_onSubmitPassword);
  }

  Future<void> _onAddDigit(AddDigit event, Emitter<PasswordState> emit) async {
    final updatedPin = List<int>.from(state.pin)..add(event.digit);
    emit(state.copyWith(pin: updatedPin));
  }

  Future<void> _onRemoveDigit(
      RemoveDigit event, Emitter<PasswordState> emit) async {
    final updatedPin = List<int>.from(state.pin);
    if (updatedPin.isNotEmpty) {
      updatedPin.removeLast();
    }
    emit(state.copyWith(pin: updatedPin));
  }

  Future<void> _onSubmitPassword(
      SubmitPassword event, Emitter<PasswordState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPin = prefs.getString('pin') ?? '';
    log(storedPin);
    print(storedPin);
    final enteredPin = state.pin.join();

    if (enteredPin == storedPin) {
      emit(state.copyWith(isSubmitted: true, isValid: true));
    } else {
      emit(state.copyWith(isSubmitted: true, isValid: false));
    }
  }

  Future<void> savePassword() async {
    final prefs = await SharedPreferences.getInstance();
    final pin = state.pin.join();
    await prefs.setString('pin', pin);
  }
}

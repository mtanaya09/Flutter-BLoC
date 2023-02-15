import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/constant/enums.dart';
import 'package:flutter_bloc_concept/logic/cubit/internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
      : super(const CounterState(counterValue: 0)) {
    internetStreamSubscription = monitorInternetCubit();
  }

  monitorInternetCubit() {
    internetCubit.listen((internetState) {
    if (internetState is InternetConnected &&
        internetState.connectionType == ConnectionType.Wifi) {
      increment();
    } else if (internetState is InternetConnected &&
        internetState.connectionType == ConnectionType.Mobile) {
      decrement();
    }
  });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));
}

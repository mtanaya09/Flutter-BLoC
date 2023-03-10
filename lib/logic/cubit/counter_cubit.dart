import 'dart:convert';
import 'package:flutter_bloc_concept/logic/cubit/internet_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit({required InternetCubit internetCubit})
      : super(const CounterState(counterValue: 0));

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  CounterState fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CounterState state) {
    // addError(
    //     Exception(
    //       "Couldn't write to storage",
    //     ),
    //     StackTrace.current);
    return state.toMap();
  }

  @override
  void onChange(Change<CounterState> change) {
    // print(
    //     'current:  ${change.currentState.counterValue} next: ${change.nextState.counterValue}');
    print(change);
    super.onChange(change);
  }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print("$error, $stackTrace");
  //   super.onError(error, stackTrace);
  // }
}

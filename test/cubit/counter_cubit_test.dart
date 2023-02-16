import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc_concept/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_concept/logic/cubit/internet_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CouterCubit', () {
    CounterCubit? counterCubit;
    setUp(() {
      counterCubit = CounterCubit(
          internetCubit: InternetCubit(connectivity: Connectivity()));
    });
    tearDown(() {
      counterCubit?.close();
    });

    test(
        'The initial state for the CounterCubit is CounterState(counterValue: 0)',
        () {
      expect(counterCubit?.state, const CounterState(counterValue: 0));
    });

    blocTest(
      'the cubit should emit a CounterState(counterValue: 1, wasIncremented: true) when the cubit.increment is called',
      build: () => CounterCubit(
          internetCubit: InternetCubit(connectivity: Connectivity())),
      act: (cubit) => cubit.increment(),
      expect: () => [const CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest(
      'the cubit should emit a CounterState(counterValue: 1, wasIncremented: false) when the cubit.decrement is called',
      build: () => CounterCubit(
          internetCubit: InternetCubit(connectivity: Connectivity())),
      act: (cubit) => cubit.decrement(),
      expect: () =>
          [const CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}

part of 'counter_cubit.dart';

class CounterState {
  final int counterValue;
  final bool? wasIncremented;

  const CounterState({
    required this.counterValue,
    this.wasIncremented,
  });

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    if (map == null) print(map);

    return CounterState(
      counterValue: map['counterValue'],
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));



  //* to debug the counterstate in console
  @override
  String toString() =>
      'CounterState(counterValue: $counterValue, wasIcremented: $wasIncremented)';
}

  // @override
  // List<Object?> get props => [counterValue, wasIncremented];


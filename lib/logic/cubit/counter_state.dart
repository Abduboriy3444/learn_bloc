part of 'counter_cubit.dart';

class CounterState {
  int counterValue;
  final wasIncremented;

  CounterState({
    required this.counterValue,
    this.wasIncremented,
  });

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue']?.toInt() ?? 0,
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  String toString() => 'CounterState(counterValue: $counterValue)';
}

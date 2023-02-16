import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concept/constant/enums.dart';
import 'package:flutter_bloc_concept/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_concept/logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.colors,
  });
  final String title;
  final Color colors;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return const Text(
                    'Wi-Fi',
                    style: TextStyle(color: Colors.green, fontSize: 30),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return const Text(
                    'Mobile',
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  );
                } else if (state is InternetDisconnected) {
                  return const Text(
                    'Disconnected',
                    style: TextStyle(color: Colors.grey, fontSize: 30),
                  );
                }
                return Container();
              },
            ),
            const Divider(height: 5),
            BlocConsumer<CounterCubit, CounterState>(
              //* COMBINING BLOC LISTENER AND BUILD IN BLOC CONSUMER

              //* BLOC LISTENER
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },

              //* BLOC BUILDER
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text('Negaaa ${state.counterValue}');
                }
                if (state.counterValue % 2 == 0) {
                  return Text('Even ${state.counterValue}');
                }
                if (state.counterValue % 2 == 1) {
                  return Text('Add ${state.counterValue}');
                }
                if (state.counterValue == 5) {
                  return Text('LIMA ${state.counterValue}');
                }
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 24),
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;

              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Mobile) {
                return Text(
                  'Counter: ${counterState.counterValue} Internet: Mobile',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Mobile) {
                return Text(
                  'Counter: ${counterState.counterValue} Internet: Wi-Fi',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              } else {
                return Text(
                  'Counter ${counterState.counterValue} Internet: Disconnected',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
            }),
            const SizedBox(height: 24),
            Builder(builder: (context) {
              final counterValue = context
                  .select((CounterCubit cubit) => cubit.state.counterValue);
              return Text(
                'Counter: $counterValue',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              color: widget.colors,
              child: const Text(
                'Go to Second Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              color: widget.colors,
              child: const Text(
                'Go to Second Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

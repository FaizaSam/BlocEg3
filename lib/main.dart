/*//async* (asynchronous generator function) keyword make a function that returns a bunch of future values one at a time.
Stream<int> dataStream() async* {
  //You can use await for to wait for each value emitted by the Stream.
  for (int i = 0; i <= 3; i++) {
    print('Sending Data ${i.toString()}');
    await Future.delayed(Duration(seconds: 3));
    yield i;
    //yield to return a value instead of return because you aren't leaving the function.
  }
}

void main(List<String> args) {
  Stream<int> stream = dataStream();
  stream.listen((event) {
    print("Receive Data ${event.toString()}");
  });
}
*/
import 'counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocCounter>(
      create: (context) => BlocCounter(),
      child: MaterialApp(
        title: "Bloc Demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: "Bloc Demo Home Page",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You have pushed the button this many times: "),
            BlocBuilder<BlocCounter, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<BlocCounter>(context)
                        .add(CounterEvent.decrement);
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<BlocCounter>(context)
                        .add(CounterEvent.increment);
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

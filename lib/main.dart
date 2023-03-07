import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollUpIntend extends Intent {}

class ScrollDownIntend extends Intent {}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int listSize = 40;
  int selectedIndex = -1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.arrowUp): ScrollUpIntend(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): ScrollDownIntend(),
        },
        child: Actions(
          actions: {
            ScrollUpIntend: CallbackAction(
              onInvoke: (intent) {
                setState(() {
                  _counter++;
                  if (selectedIndex > 0) selectedIndex--;
                });
                return null;
              },
            ),
            ScrollDownIntend: CallbackAction(
              onInvoke: (intent) {
                setState(() {
                  _counter--;
                  if (selectedIndex < listSize - 1) selectedIndex++;
                });
                return null;
              },
            ),
          },
          child: Focus(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listSize,
                      itemBuilder: (context, index) {
                        return Material(
                          child: ListTile(
                            title: Text('$index'),
                            tileColor: selectedIndex == index
                                ? Colors.blue.shade200
                                : null,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

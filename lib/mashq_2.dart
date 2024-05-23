// import 'dart:async';
// import 'dart:isolate';
// import 'package:flutter/material.dart';

// class ComputationScreen extends StatefulWidget {
//   const ComputationScreen({super.key});

//   @override
//   State<ComputationScreen> createState() => _ComputationScreenState();
// }

// class _ComputationScreenState extends State<ComputationScreen> {
//   String _result = "Waiting for result...";
//   final cl = Calculator();

//   @override
//   Widget build(BuildContext context) {
//     cl.getResult();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Heavy Computation'),
//       ),
//       body: Center(child: null
//           // FutureBuilder(
//           //   future: _startHeavyComputation(),
//           //   builder: (context, snapshot) {
//           //     if (snapshot.connectionState == ConnectionState.waiting) {
//           //       return const CircularProgressIndicator();
//           //     } else if (snapshot.hasError) {
//           //       return Text('Error: ${snapshot.error}');
//           //     } else if (snapshot.hasData) {
//           //       return Text(snapshot.data ?? 'No data');
//           //     } else {
//           //       return const Text('Unknown state');
//           //     }
//           //   },
//           // ),
//           ),
//     );
//   }
// }

// class Calculator {
//   void _heavyComputation(SendPort sendPort) {
//     int result = 0;
//     for (int i = 0; i < 1000000; i++) {
//       result += i;
//     }
//     sendPort.send(result);
//   }

//   Future<String> _startHeavyComputation() async {
//     // Create a ReceivePort to get messages from the isolate
//     ReceivePort receivePort = ReceivePort();

//     // Spawn the isolate
//     await Isolate.spawn(_heavyComputation, receivePort.sendPort);

//     // Listen for messages from the isolate
//     // receivePort.listen((message) {
//     //   // Close the ReceivePort once we have the result

//     //   receivePort.close();
//     // });
//     return receivePort.first.toString();
//   }

//   Future<String> getResult() async {
//     String res = await _startHeavyComputation();
//     print(Future.value(res).toString());
//     return Future.value(res);
//   }
// }

import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class ComputationScreen extends StatefulWidget {
  const ComputationScreen({super.key});

  @override
  State<ComputationScreen> createState() => _ComputationScreenState();
}

class _ComputationScreenState extends State<ComputationScreen> {
  late Future<String> _resultFuture;

  @override
  void initState() {
    super.initState();
    _resultFuture = Calculator().getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heavy Computation'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _resultFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Text(snapshot.data ?? 'No data');
            } else {
              return const Text('Unknown state');
            }
          },
        ),
      ),
    );
  }
}

class Calculator {
  static void _heavyComputation(SendPort sendPort) {
    int result = 0;
    for (int i = 0; i < 1000000000; i++) {
      result += i;
    }
    sendPort.send(result);
  }

  Future<String> _startHeavyComputation() async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(_heavyComputation, receivePort.sendPort);

    int result = await receivePort.first as int;
    return result.toString();
  }

  Future<String> getResult() async {
    return await _startHeavyComputation();
  }
}

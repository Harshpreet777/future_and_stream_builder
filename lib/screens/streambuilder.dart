import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({super.key});

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  late StreamController<int> streamController;
  late StreamController streamController2;

  @override
  void initState() {
    super.initState();
    streamController2 = StreamController();
    wait();
    streamController = StreamController<int>(
      onListen: () async {
        await Future.delayed(const Duration(seconds: 4));
        for (int i = 0; i <= 10; i++) {
          await Future.delayed(const Duration(seconds: 1));
          streamController.add(i);
        }
      },
    );
  }

  void wait() async {
    await Future.delayed(const Duration(seconds: 5));
    streamController2.sink.add(1);
  }

  @override
  void dispose() {
    streamController.close();
    streamController2.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: StreamBuilder(
            stream: streamController2.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return Container();
              }
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: StreamBuilder<int>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('There is no Data');
              } else {
                return ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  onPressed: null,
                  child: Text(
                    'Counting: ${snapshot.data}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

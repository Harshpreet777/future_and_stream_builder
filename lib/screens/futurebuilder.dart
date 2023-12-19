import 'dart:async';

import 'package:flutter/material.dart';
import 'package:streambuilder/screens/streambuilder.dart';

class FutureBuilderPage extends StatefulWidget {
  const FutureBuilderPage({super.key});

  @override
  State<FutureBuilderPage> createState() => _FutureBuilderPageState();
}

class _FutureBuilderPageState extends State<FutureBuilderPage> {
  Future<String> getData() {
    return Future.delayed(const Duration(seconds: 1), () {
      return 'Data';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Future Builder',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error} has occurred');
                    } else if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data}',
                        style: const TextStyle(fontSize: 25),
                      );
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Stream Builder',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const StreamBuilderPage()
            ],
          )),
    );
  }
}


import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(){
  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

void isolateFunction(int finalNum){
  int _count = 0;
  for(int i = 0; i < finalNum; i++){
    ++_count;
    if((_count % 100) == 0)
      print("isolate: " + _count.toString());
  }
}

int computeFunction(int finalNum){
  int _count = 0;
  for(int i = 0; i < finalNum; i++){
    _count++;
    if((_count % 100) == 0){
      print("compute: " + _count.toString());
    }
  }
  int index = (_count / 100).toInt();
  return index;
}


class _MyAppState extends State<MyApp> {
  int count = 0;


  @override
  void initState() {
    Isolate.spawn(isolateFunction, 1000);
    super.initState();
  }

  Future<void> runCompute() async {
    count  = await compute(computeFunction, 2000);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text(count.toString()),
              RaisedButton(
                onPressed: () {
                 count++;
                 setState(() {
                 });
                },
                child: Text("Add"),
              ),
              RaisedButton(onPressed: (){
                runCompute();
              }, child: Text("Add in isolate"),),
            ],
          ),
        ),
      ),
    );
  }
}


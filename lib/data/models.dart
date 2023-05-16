import 'dart:math';

import 'package:flutter/material.dart';

class ResultData {
  // final testType = null;

  /*
  have a CSV style export?
  nah, just give out named arrays.
  */
}

@immutable
class InputData {
  // InputData({
  //   required this.target1,
  //   required this.target2,
  //   required this.value1,
  //   required this.value2,
  // });

  // final String target1;
  // final String target2;
  // final String value1;
  // final String value2;

  final String target1 = 'Insect';
  final List<String> target1List = [
    'cockroach',
    'mosquito',
    'fly',
  ];

  final String target2 = 'Flower';
  final List<String> target2List = [
    'dandelions',
    'rose',
    'mariegolds',
  ];

  final String value1 = 'Good';
  final List<String> value1List = [
    'Happiness',
  ];

  final String value2 = 'Bad';
  final List<String> value2List = [
    'pain',
    'suffering',
  ];

  /*
  Flowers and Insects are targets.
  Good and Bad are values.

  Values stay fixed.

  implement Pictures as target list.
  */

  List<String> get allTargetList => target1List + target2List;
  List<String> get allValueList => value1List + value2List;
  List<String> get allList =>
      value1List + value2List + target1List + target2List;
}

class TestService {
  final inputData = InputData();
  int phase = 1;
  final _lengths = [
    1,
    2,
    3,
    4,
    5,
  ];

  List<String> getPrompts() {
    var lis = <String>[];
    switch (phase) {
      case 1:
        // v1 and v2
        lis = (getRandomListWithReplacement(
          list: inputData.allValueList,
        ));
        break;
      case 2:
        // t1 and t2
        lis = (getRandomListWithReplacement(
          list: inputData.allTargetList,
        ));
        break;
      case 3:
        //  v1/t1 and v2/t2 //should randomize this
        lis = (getRandomListWithReplacement(
          list: inputData.allList,
        ));
        break;

      case 4:
        // t2 and t1
        lis = (getRandomListWithReplacement(
          list: inputData.allTargetList,
        ));
        break;

      case 5:
        lis = (getRandomListWithReplacement(
          list: inputData.allList,
        ));
        break;
    }
    phase++;

    return lis;
  }

  String get currentLeft => {
        1: inputData.value1,
        2: inputData.target1,
        3: '${inputData.value1}\n${inputData.target1}',
        4: inputData.target2,
        5: '${inputData.value1}\n${inputData.target2}',
      }[phase]!;

  String get currentRight => {
        1: inputData.value2,
        2: inputData.target2,
        3: '${inputData.value2}\n${inputData.target2}',
        4: inputData.target1,
        5: '${inputData.value2}\n${inputData.target2}',
      }[phase]!;

  List<String> getRandomListWithReplacement({
    int? length,
    required List list,
  }) {
    final n = length ?? _lengths[phase];
    return List.generate(n, (_) => list[Random().nextInt(n)]);
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/calling_controller.dart';

class CallingView extends GetView<CallingController> {
  const CallingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CallingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CallingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

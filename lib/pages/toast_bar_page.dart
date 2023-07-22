import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToastBarPage extends StatelessWidget {
  const ToastBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            const channel = MethodChannel('toastBar');
            channel.invokeListMethod('ShowToastBar');
          },
          child: const Text("Show Toast"),
        ),
      ),
    );
  }
}

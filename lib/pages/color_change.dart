import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeColorPage extends StatefulWidget {
  const ChangeColorPage({super.key});

  @override
  State<ChangeColorPage> createState() => _ChangeColorPageState();
}

class _ChangeColorPageState extends State<ChangeColorPage> {
  final channel = const MethodChannel('ChangeColor');
  String color = "0xfffffffff";

  void setColor(clr) {
    setState(() {
      color = clr;
    });
  }

  changeColor() async {
    var res = await channel.invokeMethod("ChangeBackgorundColor");
    setColor(res);
  }

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
      backgroundColor: Color(int.parse(color)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setColor("0xff1f212c");
              },
              child: const Text("Flutter"),
            ),
            ElevatedButton(
              onPressed: changeColor,
              child: const Text("Native"),
            ),
          ],
        ),
      ),
    );
  }
}

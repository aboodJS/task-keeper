import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: textInputBox(),
        appBar: AppBar(title: Text("task Keeper"), centerTitle: true),
      ),
    );
  }
}

class textInputBox extends StatefulWidget {
  const textInputBox({super.key});

  @override
  State<textInputBox> createState() => _textInputBoxState();
}

class _textInputBoxState extends State<textInputBox> {
  TextEditingController controller = TextEditingController();
  String text = "hi!";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: TextField(controller: controller),
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                text = controller.text;
              }),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        Text(text),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future createFile(String str) async {
  final path = await getApplicationDocumentsDirectory();
  final file = File("${path.path}/tasks.txt");
  await file.writeAsString("$str\n", mode: FileMode.append);
}

Future deleteItem(List<String> arr, String str) async {
  final path = await getApplicationDocumentsDirectory();
  final file = File("${path.path}/tasks.txt");
  arr.removeWhere((e) => e == str);
  file.writeAsStringSync("${arr.join("\n")}\n", mode: FileMode.write);
}

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
        appBar: AppBar(title: Text("مهامي"), centerTitle: true),
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
  List<String> userInput = [];

  Future openFile() async {
    final path = await getApplicationDocumentsDirectory();
    final file = File("${path.path}/tasks.txt");
    print(file.readAsStringSync());
    setState(() {
      userInput = file.readAsStringSync().split("\n");
    });
  }

  @override
  void initState() {
    super.initState();
    openFile();
  }

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
              onPressed: () async {
                setState(() {
                  if (controller.text.trim().isNotEmpty) {
                    userInput.add(controller.text.trim());
                    createFile(controller.text.trim());
                    controller.clear();
                    print(userInput);
                  } else {
                    print("please enter a vaild string");
                  }
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        for (String task in userInput)
          if (task.isNotEmpty)
            Container(
              width: 350,

              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                spacing: 70.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      userInput.removeWhere((e) => e == task);
                      print(task);
                      print(userInput);
                      deleteItem(userInput, task);
                    }),
                    icon: Icon(Icons.check, color: Colors.white),
                  ),
                  Text(
                    task,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

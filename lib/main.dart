import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future createFile(String str) async {
  final path = await getApplicationDocumentsDirectory();
  final file = File("${path.path}/tasks.txt");

  await file.writeAsString("$str\n", mode: FileMode.append);
}

Future deleteItem(List<String> arr) async {
  final path = await getApplicationDocumentsDirectory();
  final file = File("${path.path}/tasks.txt");

  file.writeAsStringSync(arr.join("\n").trim());
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
  List<String> userInput = [];

  Future openFile() async {
    final path = await getApplicationDocumentsDirectory();
    final file = File("${path.path}/tasks.txt");
    print(file.readAsStringSync());
    setState(() {
      userInput = file.readAsStringSync().trim().split("\n");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
                final path = await getApplicationDocumentsDirectory();
                final file = File("${path.path}/tasks.txt");
                print("${path.path}");
                setState(() {
                  if (controller.text.trim().isNotEmpty) {
                    createFile(controller.text.trim());
                    userInput.add(controller.text.trim());
                    print(userInput);
                    controller.clear();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(task),
                IconButton(
                  onPressed: () => setState(() {
                    userInput.remove(task);
                    print(userInput);
                    deleteItem(userInput);
                  }),
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
      ],
    );
  }
}

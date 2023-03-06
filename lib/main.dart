import 'package:flutter/material.dart';

const List<String> list = <String>['ปลานิล', 'ปลาบึก'];

void main() => runApp(const DropdownButtonApp());

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('โปรแกรมคำนวณหาราคาปลานิล และปลาบึก')),
        body: const Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  final fieldText = TextEditingController();

  get value => null;

  void clearText() {
    fieldText.clear();
  }

  String fish = 'ปลานิล';
  double wight = 0;
  double fishpiece = 80;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Image(
            image: NetworkImage(
                'https://th.bing.com/th/id/R.2be15242e99a4efa839d3aa549c31c1b?rik=7p1Mz8tyDLERnQ&riu=http%3a%2f%2f3.bp.blogspot.com%2f-eCpJXvyKd2U%2fUORhqSIYkbI%2fAAAAAAAAABU%2f4J1a7QSNums%2fs1600%2ffish.png&ehk=f6U%2bEWWEX90XohyDo1iXamCDwQWxeSnGHA5Bi21adBA%3d&risl=&pid=ImgRaw&r=0'),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 1,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              if (value == 'ปลาบึก') {
                fishpiece = 100;
                fish = value!;
              } else {
                fishpiece = 80;
                fish = value!;
              }

              setState(() {
                dropdownValue = value;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: fieldText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'กรอกน้ำหนักปลา',
            ),
            onChanged: (String value) {
              wight = int.parse(value) as double;
            },
            onSubmitted: (String value) async {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('แจ้งเตือน!!'),
                    content: Text(
                        'คุณซื้อ $fish น้ำหนัก $wight จะต้องจ่ายราคา ${fishpiece * wight} บาท'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('แจ้งเตือน!!'),
                  content: Text(
                      "คุณซื้อ $fish น้ำหนัก $wight จะต้องจ่ายราคา ${fishpiece * wight} บาท"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(14),
                        child: const Text("okay"),
                      ),
                    ),
                  ],
                ),
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            child: const Text('คำนวณ'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: clearText,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 175, 160, 76))),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

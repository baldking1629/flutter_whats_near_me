import 'package:flutter/material.dart';
import 'package:flutter_whats_near_me/widgets/appbar_widget.dart';
import 'package:flutter_whats_near_me/widgets/entry_point.dart';


List<String> types = <String>[
  "gym",
  "cafe",
  "pharmacy",
  "hospital",
  "restaurant"
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = types.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What is near me! Select type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 35,
            ),
            DropdownMenu<String>(
              initialSelection: types.first,
              onSelected: (String? value) {
                dropdownValue = value!;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EntryPoint(
                              object: value,
                            )));
              },
              dropdownMenuEntries:
                  types.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry(value: value, label: value);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:face_pile_plus/face_pile_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var visible = <UserInfo>[];

  var placeholder = <UserInfo>[
    UserInfo(
      name: "Alejandro Escamilla",
      avatar: "https://picsum.photos/id/0/150/150",
    ),
    UserInfo(
      name: "Alejandro Escamilla",
      avatar: "https://picsum.photos/id/1/150/150",
    ),
    UserInfo(
      name: "Paul Jarvis",
      avatar: "https://picsum.photos/id/10/150/150",
    ),
    UserInfo(
      name: "Tina Rataj",
      avatar: "https://picsum.photos/id/100/150/150",
    ),
    UserInfo(
      name: "Lukas Budimaier",
      avatar: "https://picsum.photos/id/1000/150/150",
    ),
    UserInfo(
      name: "Danielle MacInnes",
      avatar: "https://picsum.photos/id/1001/150/150",
    ),
    UserInfo(
      name: "NASA",
      avatar: "https://picsum.photos/id/1002/150/150",
    ),
    UserInfo(
      name: "E+N Photographies",
      avatar: "https://picsum.photos/id/1003/150/150",
    ),
    UserInfo(
      name: "Greg Rakozy",
      avatar: "https://picsum.photos/id/1004/150/150",
    ),
    UserInfo(
      name: "Matthew Wiebe",
      avatar: "https://picsum.photos/id/1005/150/150",
    ),
    UserInfo(
      name: "Vladimir Kudinov",
      avatar: "https://picsum.photos/id/1006/150/150",
    ),
    UserInfo(
      name: "Benjamin Combs",
      avatar: "https://picsum.photos/id/1008/150/150",
    ),
    UserInfo(
      name: "Christopher Campbell",
      avatar: "https://picsum.photos/id/1009/150/150",
    ),
    UserInfo(
      name: "Christian Bardenhorst",
      avatar: "https://picsum.photos/id/101/150/150",
    ),
    UserInfo(
      name: "Samantha Sophia",
      avatar: "https://picsum.photos/id/1010/150/150",
    )
  ];

  void _addUser() {
    if (placeholder.isNotEmpty) {
      setState(() => visible.add(placeholder.removeLast()));
    }
  }

  void _removeUser() {
    if (visible.isNotEmpty) {
      final index = Random().nextInt(visible.length);
      setState(() => placeholder.insert(0, visible.removeAt(index)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FacePile(users: visible),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _removeUser,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 24),
          FloatingActionButton(
            onPressed: _addUser,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final Function(String) onNameChanged;

  const ProfilePage({
    super.key,
    required this.username,
    required this.onNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(username),
          ElevatedButton(
            onPressed: () {
              onNameChanged("Nama Baru");
            },
            child: const Text("Ganti Nama"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
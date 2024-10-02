import 'package:flutter/material.dart';
import 'package:smart_app/presentation/components/CustomBox.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CenteredColumn(content: Text("Users")),
    );
  }
}

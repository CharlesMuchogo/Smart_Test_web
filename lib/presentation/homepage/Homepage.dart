// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Test", style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          TextButton(onPressed: null, child: Text("Home", style: Theme.of(context).textTheme.titleMedium)),
          TextButton(onPressed: null, child: Text("About", style: Theme.of(context).textTheme.titleMedium)),
          TextButton(onPressed: null, child: Text("Contacts", style: Theme.of(context).textTheme.titleMedium)),
          TextButton(onPressed: null, child: Text("Clinics", style: Theme.of(context).textTheme.titleMedium)),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12),

      ),
    );
  }
}

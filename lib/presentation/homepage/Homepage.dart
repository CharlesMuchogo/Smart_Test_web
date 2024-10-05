// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/bloc/Results/results_bloc.dart';
import 'package:smart_app/presentation/clinics/clinicsPage.dart';
import 'package:smart_app/presentation/results/ResultsPage.dart';

import '../users/users_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int activePage = 0;

  List<Widget> pages = [ResultsPage(), ClinicsPage(), UsersPage()];

  @override
  Widget build(BuildContext context) {
    context.read<ResultsBloc>().add(GetTestResults(context: context));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Smart Test",
              style: Theme.of(context).textTheme.headlineSmall),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    activePage = 0;
                  });
                },
                child: Text("Results",
                    style: Theme.of(context).textTheme.titleMedium)),
            TextButton(
                onPressed: () {
                  setState(() {
                    activePage = 1;
                  });
                },
                child: Text("Clinics",
                    style: Theme.of(context).textTheme.titleMedium)),
            SizedBox(width: 16),
            TextButton(
                onPressed: () {
                  setState(() {
                    activePage = 2;
                  });
                },
                child: Text("Users",
                    style: Theme.of(context).textTheme.titleMedium)),
            SizedBox(width: 16),
          ],
        ),
        body: pages[activePage]);
  }
}

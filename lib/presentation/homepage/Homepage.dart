// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/Utils/utils.dart';
import 'package:smart_app/bloc/Results/results_bloc.dart';
import 'package:smart_app/presentation/clinics/clinicsPage.dart';
import 'package:smart_app/presentation/results/AppImage.dart';
import 'package:smart_app/presentation/results/ResultsPage.dart';

import '../../bloc/Clinics/clinics_bloc.dart';
import '../../bloc/Users/users_bloc.dart';
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
    context.read<ClinicsBloc>().add(GetClinics(context: (context)));
    context.read<UsersBloc>().add(GetUsers(context: context));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Smart Test",
              style: Theme.of(context).textTheme.headlineSmall),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/results");
                },
                child: Text("Results",
                    style: Theme.of(context).textTheme.titleMedium)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/clinics");
                },
                child: Text("Clinics",
                    style: Theme.of(context).textTheme.titleMedium)),
            const SizedBox(width: 16),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/users");
                },
                child: Text("Users",
                    style: Theme.of(context).textTheme.titleMedium)),
            SizedBox(width: 16),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<ResultsBloc, ResultsState>(
                      builder: (context, state) {

                        if (state.status == ResultsStatus.loaded || state.results.isNotEmpty) {
                          return Text(
                            "${state.results.length} Results",
                          );
                        }


                        if (state.status == ResultsStatus.loading) {
                          return SizedBox(height: 20, width: 20, child: CircularProgressIndicator());
                        }

                        return Text(
                          "0 Results",
                        );
                      },
                    ),
                  ),
                ),



                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<ClinicsBloc, ClinicsState>(
                      builder: (context, state) {

                        if (state.status == ClinicsStatus.loaded || state.clinics.isNotEmpty) {
                          return Text(
                            "${state.clinics.length} Clinics",
                          );
                        }


                        if (state.status == ClinicsStatus.loading) {
                          return SizedBox(height: 20, width: 20, child: CircularProgressIndicator());
                        }

                        return Text(
                          "0 Clinics",
                        );
                      },
                    ),
                  ),
                ),




                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<UsersBloc, UsersState>(
                      builder: (context, state) {

                        if (state.status == UsersBlocStatus.loaded || state.users.isNotEmpty) {
                          return Text(
                            "${state.users.length} Users",
                          );
                        }


                        if (state.status == UsersBlocStatus.loading) {
                          return SizedBox(height: 20, width: 20, child: CircularProgressIndicator());
                        }


                        return Text(
                          "0 Users",
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

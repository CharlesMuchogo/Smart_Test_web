// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/Utils/utils.dart';
import 'package:smart_app/bloc/Results/results_bloc.dart';
import 'package:smart_app/domain/models/test_results.dart';
import 'package:smart_app/presentation/components/CustomBox.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
                onPressed: null,
                child: Text("Home",
                    style: Theme.of(context).textTheme.titleMedium)),
            TextButton(
                onPressed: null,
                child: Text("About",
                    style: Theme.of(context).textTheme.titleMedium)),
            TextButton(
                onPressed: null,
                child: Text("Contacts",
                    style: Theme.of(context).textTheme.titleMedium)),
            TextButton(
                onPressed: null,
                child: Text("Clinics",
                    style: Theme.of(context).textTheme.titleMedium)),
            SizedBox(width: 16),
          ],
        ),
        body: BlocBuilder<ResultsBloc, ResultsState>(
          builder: (context, state) {
            if (state.status == ResultsStatus.loading &&
                state.results.isEmpty) {
              return CenteredColumn(
                content: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state.status == ResultsStatus.error && state.results.isEmpty) {
              return CenteredColumn(content: Text(state.message));
            }

            if (state.status == ResultsStatus.loaded && state.results.isEmpty) {
              return CenteredColumn(content: Text("No results at the moment"));
            }

            List<TestResult> results =
                state.results.map((e) => TestResult.fromJson(e)).toList();
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'No.',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Results',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Results Image',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Partner Results',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Results Image',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: results
                    .asMap()
                    .map((index, result) => MapEntry(
                          index,
                          DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(result.date)),
                            DataCell(Text(result.results)),
                            DataCell(
                              result.results.isNotEmpty
                                  ?
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child:  CachedNetworkImage(
                                          imageUrl: mockImage1Url,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                            child:
                                            Icon(
                                              Icons.image_not_supported,
                                              size: 30,
                                            ),
                                          ),
                                        )

                                ),
                              ): Text("N/A"),
                            ),
                            DataCell(Text(result.partnerResults)),
                            DataCell(
                              result.partnerResults.isNotEmpty
                                  ?
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child:  CachedNetworkImage(
                                          imageUrl: mockImageUrl,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                          const Center(
                                            child:
                                            Icon(
                                              Icons.image_not_supported,
                                              size: 30,
                                            ),
                                          ),
                                        )
                                ),
                              ): Text("N/A"),
                            ),
                          ]),
                        ))
                    .values
                    .toList(),
              ),
            );
          },
        ));
  }
}

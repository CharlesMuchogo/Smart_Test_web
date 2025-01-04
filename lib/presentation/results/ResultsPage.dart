import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/domain/models/test_results.dart';
import 'package:smart_app/presentation/results/results_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../Utils/utils.dart';
import '../../bloc/Results/results_bloc.dart';
import '../components/CustomBox.dart';
import 'AppImage.dart';
import 'EditResultsDialog.dart';
import 'ImageDialog.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

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
          const SizedBox(width: 16),
        ],
      ),
      body: BlocListener<ResultsBloc, ResultsState>(
        listener: (context, state) {
          // You can listen to state changes here if needed
        },
        child: BlocBuilder<ResultsBloc, ResultsState>(
          builder: (context, state) {
            if (state.status == ResultsStatus.loading && state.results.isEmpty) {
              return const CenteredColumn(
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
              return const CenteredColumn(
                  content: Text("No results at the moment"));
            }

            List<TestResult> results =
                state.results.map((e) => TestResult.fromJson(e)).toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SfDataGrid(
                columnWidthMode: ColumnWidthMode.auto,
                allowColumnsResizing: true,
                allowSorting: true,
                selectionMode: SelectionMode.multiple,
                source: ResultsDataSource(results, context),
                isScrollbarAlwaysShown: true,
                columns: [
                  GridColumn(
                    allowSorting: true,
                    columnName: 'No.',
                    label: const Center(child: Text('No.')),
                  ),
                  GridColumn(
                    columnName: 'User',
                    label: const Center(child: Text('User')),
                  ),
                  GridColumn(
                    columnName: 'Date',
                    label: const Center(child: Text('Date')),
                  ),
                  GridColumn(
                    columnName: 'Results',
                    label: const Center(child: Text("Results")),
                  ),
                  GridColumn(
                    columnName: 'Result Image',
                    label: const Center(child: Text('Result Image')),
                    width: 130,
                  ),
                  GridColumn(
                    columnName: 'Partner Results',
                    label: const Center(child: Text('Partner Results')),
                  ),
                  GridColumn(
                    columnName: 'Partner Image',
                    label: const Center(child: Text('Partner Image')),
                    width: 130,
                  ),
                  GridColumn(
                    columnName: 'Care Option',
                    label: const Center(child: Text('Care Option')),
                  ),
                  GridColumn(
                    columnName: 'Status',
                    label: const Center(child: Text('Status')),
                  ),
                  GridColumn(
                    columnName: 'Action',
                    label: const Center(child: Text('Action')),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

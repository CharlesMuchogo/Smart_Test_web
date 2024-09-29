import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/domain/models/test_results.dart';

import '../../Utils/utils.dart';
import '../../bloc/Results/results_bloc.dart';
import '../components/CustomBox.dart';
import 'AppImage.dart';
import 'EditResultsDialog.dart';
import 'ImageDialog.dart';
import 'enums.dart';

class ResusltsPage extends StatelessWidget {
  const ResusltsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResultsBloc, ResultsState>(
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

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: _buildColumns(context),
              rows: _buildRows(context, results),
            ),
          );
        },
      ),
    );
  }

  // Extract columns to a method to simplify the builder logic
  List<DataColumn> _buildColumns(BuildContext context) {
    return <DataColumn>[
      _buildColumn(context, 'No.'),
      _buildColumn(context, 'Date'),
      _buildColumn(context, 'User'),
      _buildColumn(context, 'Results'),
      _buildColumn(context, 'Results Image'),
      _buildColumn(context, 'Partner Results'),
      _buildColumn(context, 'Partner Image'),
      _buildColumn(context, 'Care Option'),
      _buildColumn(context, 'Action'),
    ];
  }

  // Helper method to build columns
  DataColumn _buildColumn(BuildContext context, String label) {
    return DataColumn(
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Extract row building to a method
  List<DataRow> _buildRows(BuildContext context, List<TestResult> results) {
    return results
        .asMap()
        .map(
          (index, result) {
            return MapEntry(
              index,
              DataRow(cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(result.date)),
                DataCell(
                    Text("${result.user.firstName} ${result.user.lastName}")),
                DataCell(Text(result.results)),
                DataCell(
                  AppImage(
                      image: result.image,
                      onClick: () {
                        showImageDialog(
                          context,
                          "${result.user.firstName} results",
                          "$baseUrl${result.image}",
                        );
                      }),
                ),
                DataCell(Text(result.partnerResults)),
                DataCell(
                  AppImage(
                      image: result.partnerImage,
                      onClick: () {
                        showImageDialog(
                          context,
                          "${result.user.firstName} partner result",
                          "$baseUrl${result.partnerImage}",
                        );
                      }),
                ),
                DataCell(
                  result.careOption != null
                      ? Text(result.careOption!)
                      : const Text("N/A"),
                ),
                DataCell(
                  IconButton(
                    onPressed: (){
                      showEditResultsDialog(
                        context,
                        result,
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ]),
            );
          },
        )
        .values
        .toList();
  }
}

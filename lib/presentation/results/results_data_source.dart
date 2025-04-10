import 'package:flutter/material.dart';
import 'package:smart_app/domain/models/test_results.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../Utils/utils.dart';
import 'AppImage.dart';
import 'EditResultsDialog.dart';
import 'ImageDialog.dart';

class ResultsDataSource extends DataGridSource {
  final List<TestResult> results;
  final BuildContext context;

  ResultsDataSource(this.results, this.context) {
    _dataGridRows = results.toList().asMap().entries.map<DataGridRow>((entry) {
      final index = entry.key; // The reverse index
      final result = entry.value;

      return DataGridRow(cells: [
        DataGridCell(columnName: 'No.', value: results.length - index),
        DataGridCell(
            columnName: 'User',
            value:
                "${capitalize(result.user.firstName)} ${capitalize(result.user.lastName)}"),
        DataGridCell(columnName: 'Date', value: result.date),
        DataGridCell(columnName: 'Results', value: result.results),
        DataGridCell(columnName: 'Result Image', value: result.image),
        DataGridCell(
            columnName: 'Partner Result', value: result.partnerResults),
        DataGridCell(columnName: 'Partner Image', value: result.partnerImage),
        DataGridCell(
            columnName: 'Care Option',
            value: result.careOption != null ? result.careOption! : "N/A"),
        DataGridCell(columnName: 'Status', value: result.status),
        DataGridCell(columnName: 'Action', value: result),
      ]);
    }).toList();
  }

  late List<DataGridRow> _dataGridRows;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final result = row.getCells()[9].value as TestResult;

    return DataGridRowAdapter(cells: [
      _buildDataCell(
          label: row.getCells()[0].value.toString(),
          alignment: Alignment.center),
      _buildDataCell(label: row.getCells()[1].value.toString()),
      _buildDataCell(label: row.getCells()[2].value.toString()),
      _buildDataCell(label: row.getCells()[3].value.toString()),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: AppImage(
              image: row.getCells()[4].value.toString(),
              onClick: () {
                showImageDialog(
                  context,
                  "${row.getCells()[1].value.toString()} results",
                  row.getCells()[4].value.toString().startsWith("https")
                      ? row.getCells()[4].value.toString()
                      : "$baseUrl${row.getCells()[4].value.toString()}",
                );
              })),
      _buildDataCell(label: row.getCells()[5].value.toString()),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          height: 50,
          width: 50,
          alignment: Alignment.center,
          child: AppImage(
              image: row.getCells()[6].value.toString(),
              onClick: () {
                showImageDialog(
                  context,
                  "${row.getCells()[1].value.toString()} partner results",
                  row.getCells()[6].value.toString().startsWith("http")
                      ? row.getCells()[6].value.toString()
                      : "$baseUrl${row.getCells()[6].value.toString()}",
                );
              })),
      _buildDataCell(label: row.getCells()[7].value.toString()),
      _buildDataCell(label: row.getCells()[8].value.toString()),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: IconButton(
          onPressed: () {
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
    ]);
  }

  _buildDataCell(
      {required String label, Alignment alignment = Alignment.centerLeft}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: alignment,
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

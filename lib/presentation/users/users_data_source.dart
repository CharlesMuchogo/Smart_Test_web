import 'package:flutter/material.dart';
import 'package:smart_app/domain/models/user.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../components/AppProfileIcon.dart';

class UserDataSource extends DataGridSource {
  final List<User> users;

  UserDataSource(this.users) {
    _dataGridRows = users.toList().asMap().entries.map<DataGridRow>((entry) {
      final index = entry.key; // The reverse index
      final user = entry.value;

      return DataGridRow(cells: [
        DataGridCell(columnName: 'No.', value: users.length - index),
        DataGridCell(columnName: 'Image', value: user.profilePhoto),
        DataGridCell(columnName: 'FirstName', value: user.firstName),
        DataGridCell(columnName: 'LastName', value: user.lastName),
        DataGridCell(columnName: 'Phone', value: user.phone),
        DataGridCell(columnName: 'Email', value: user.email),
        DataGridCell(columnName: 'Age', value: user.age),
        DataGridCell(columnName: 'Education Level', value: user.educationLevel),
        DataGridCell(columnName: 'Gender', value: user.gender),
        DataGridCell(columnName: 'Tested before', value: user.testedBefore),
      ]);
    }).toList();
  }

  late List<DataGridRow> _dataGridRows;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
    _buildDataCell(label: row.getCells()[0].value.toString(), alignment: Alignment.center),

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        alignment: Alignment.center,
        child: AppProfileIcon(imageUrl: row.getCells()[1].value.toString()),
      ),
      _buildDataCell(label: row.getCells()[2].value.toString()),
      _buildDataCell(label: row.getCells()[3].value.toString()),
      _buildDataCell(label: row.getCells()[4].value.toString()),
      _buildDataCell(label: row.getCells()[5].value.toString()),
      _buildDataCell(label: row.getCells()[6].value.toString()),
      _buildDataCell(label: row.getCells()[7].value.toString()),
      _buildDataCell(label: row.getCells()[8].value.toString()),
      Checkbox(
        value: row.getCells()[9].value as bool,
        onChanged: null,
      ),
    ]);
  }

  _buildDataCell({required String label, Alignment alignment = Alignment.centerLeft}){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: alignment,
      child: Text(label, overflow: TextOverflow.ellipsis,),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_app/domain/models/user.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../components/AppProfileIcon.dart';

class UserDataSource extends DataGridSource {
  final List<User> users;

  UserDataSource(this.users) {
    _dataGridRows = users.map<DataGridRow>((user) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'No.', value: users.indexOf(user) + 1),
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
      Text(row.getCells()[0].value.toString()),

      Padding(
        padding: const EdgeInsets.all(12.0),
        child: AppProfileIcon(imageUrl: row.getCells()[1].value.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(row.getCells()[3].value.toString()),
      ),
      Text(row.getCells()[4].value.toString()),
      Text(row.getCells()[5].value.toString()),
      Text(row.getCells()[6].value.toString()),
      Text(row.getCells()[7].value.toString()),
      Text(row.getCells()[8].value.toString()),
      Checkbox(
        value: row.getCells()[9].value as bool,
        onChanged: null,
      ),
    ]);
  }
}

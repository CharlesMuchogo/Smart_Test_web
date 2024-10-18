import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/bloc/Users/users_bloc.dart';
import 'package:smart_app/domain/models/user.dart';
import 'package:smart_app/presentation/components/AppProfileIcon.dart';
import 'package:smart_app/presentation/components/CustomBox.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UsersBloc>().add(GetUsers(context: context));
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state.status == ResultsStatus.loading && state.users.isEmpty) {
            return const CenteredColumn(
              content: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.status == ResultsStatus.error && state.users.isEmpty) {
            return CenteredColumn(content: Text(state.message));
          }

          if (state.status == ResultsStatus.loaded && state.users.isEmpty) {
            return const CenteredColumn(
              content: Text("No users at the moment"),
            );
          }

          List<User> users = state.users.map((e) => User.fromJson(e)).toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: InteractiveViewer(
              maxScale: 1,
              minScale: 1,
              constrained: false,
              child: DataTable(
                border: TableBorder(
                    horizontalInside: BorderSide(
                  width: 0.4,
                  color: Colors.grey.shade200,
                )),
                headingRowColor: WidgetStateProperty.all(
                    const Color.fromRGBO(243, 244, 248, 100)),
                columns: _buildColumns(context),
                rows: _buildRows(context, users),
              ),
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
      _buildColumn(context, 'Image'),
      _buildColumn(context, 'FirstName'),
      _buildColumn(context, 'LastName'),
      _buildColumn(context, 'Phone'),
      _buildColumn(context, 'Email'),
      _buildColumn(context, 'Age'),
      _buildColumn(context, 'Education Level'),
      _buildColumn(context, 'Gender'),
      _buildColumn(context, 'Tested before'),
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
  List<DataRow> _buildRows(BuildContext context, List<User> results) {
    return results
        .asMap()
        .map(
          (index, user) {
            return MapEntry(
              index,
              DataRow(cells: [
                DataCell(Text('${index + 1}')),
                DataCell(AppProfileIcon(imageUrl: user.profilePhoto)),
                DataCell(Text(user.firstName)),
                DataCell(Text(user.lastName)),
                DataCell(Text(user.phone)),
                DataCell(Text(user.email)),
                DataCell(Text(user.age)),
                DataCell(Text(user.educationLevel)),
                DataCell(Text(user.gender)),
                DataCell(Checkbox(value: user.testedBefore, activeColor: Colors.blue ,onChanged: null)),
              ]),
            );
          },
        )
        .values
        .toList();
  }
}

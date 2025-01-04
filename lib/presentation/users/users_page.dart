import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/bloc/Users/users_bloc.dart';
import 'package:smart_app/domain/models/user.dart';
import 'package:smart_app/presentation/components/AppProfileIcon.dart';
import 'package:smart_app/presentation/components/CustomBox.dart';
import 'package:smart_app/presentation/users/users_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
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
          child: SfDataGrid(
            columnWidthMode: ColumnWidthMode.auto,
            allowColumnsResizing: true,
            allowSorting: true,
            selectionMode: SelectionMode.multiple,
            source: UserDataSource(users),
            isScrollbarAlwaysShown: true,
            columns: [
              GridColumn(
                allowSorting: true,
                columnName: 'No.',
                label: const Center(child: Text('No.')),
              ),
              GridColumn(
                columnName: 'Image',
                label: const Center(child: Text('Image')),
              ),
              GridColumn(
                columnName: 'FirstName',
                label: const Center(child: Text('First Name')),
              ),
              GridColumn(
                columnName: 'LastName',
                label: const Center(child: Text('Last Name')),
              ),
              GridColumn(
                columnName: 'Phone',
                label: const Center(child: Text('Phone')),
              ),
              GridColumn(
                columnName: 'Email',
                width: 250,
                label: const Center(child: Text('Email')),
              ),
              GridColumn(
                columnName: 'Age',
                label: const Center(child: Text('Age')),
              ),
              GridColumn(
                columnName: 'Education Level',
                label: const Center(child: Text('Education Level')),
              ),
              GridColumn(
                columnName: 'Gender',
                label: const Center(child: Text('Gender')),
              ),
              GridColumn(
                columnName: 'Tested before',
                label: const Center(child: Text('Tested Before')),
              ),
            ],
          ),
        );
      }),
    );
  }
}

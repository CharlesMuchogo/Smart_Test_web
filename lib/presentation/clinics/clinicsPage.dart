import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/bloc/Clinics/clinics_bloc.dart';
import 'package:smart_app/domain/models/clinic.dart';
import 'package:smart_app/presentation/components/CustomBox.dart';

class ClinicsPage extends StatelessWidget {
  const ClinicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ClinicsBloc>().add(GetClinics(context: (context)));
    return BlocBuilder<ClinicsBloc, ClinicsState>(
      builder: (context, state) {
        if (state.status == ResultsStatus.loading && state.clinics.isEmpty) {
          return const CenteredColumn(
            content: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.status == ResultsStatus.error && state.clinics.isEmpty) {
          return CenteredColumn(content: Text(state.message));
        }

        if (state.status == ResultsStatus.loaded && state.clinics.isEmpty) {
          return const CenteredColumn(
              content: Text("No clinics at the moment"));
        }

        List<Clinic> clinics =
            state.clinics.map((e) => Clinic.fromJson(e)).toList();

        return Scaffold(
          floatingActionButton: const FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add),
          ),
          body: SingleChildScrollView(
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
                    'Name',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Address',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Contacts',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: clinics
                  .asMap()
                  .map(
                    (index, clinic) => MapEntry(
                      index,
                      DataRow(cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(clinic.name)),
                        DataCell(Text(clinic.address)),
                        DataCell(Text(clinic.contacts)),
                        DataCell(Text(clinic.active ? "Active" : "Inactive")),
                      ]),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

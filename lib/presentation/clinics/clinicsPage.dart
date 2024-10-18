import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/bloc/Clinics/clinics_bloc.dart';
import 'package:smart_app/domain/models/clinic.dart';
import 'package:smart_app/presentation/components/CustomBox.dart';

import 'addClinicDialog.dart';

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

        List<Clinic> clinics =
            state.clinics.map((e) => Clinic.fromJson(e)).toList();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InteractiveViewer(
              constrained: false,
              maxScale: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        showAddClinicDialog(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Add Clinic"),
                        ],
                      )),

                  DataTable(
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
                      DataColumn(
                        label: Text(
                          'Actions',
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
                              DataCell(
                                  Text(clinic.active ? "Active" : "Inactive")),
                              DataCell(
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

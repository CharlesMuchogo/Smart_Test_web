import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/bloc/Clinics/clinics_bloc.dart';
import 'package:smart_app/domain/dto/clinics/create_clinic_request_dto.dart';
import 'package:smart_app/presentation/components/AppTextField.dart';

void showAddClinicDialog(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Add Clinic"),
        content: SizedBox(
          width: min(MediaQuery.of(context).size.width * 0.6, 500),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                      label: "Name",
                      textInputType: TextInputType.text,
                      icon: const Icon(Icons.person),
                      onSaved: () {},
                      controller: nameController),
                  AppTextField(
                      label: "Contacts",
                      textInputType: TextInputType.phone,
                      icon: const Icon(Icons.phone),
                      onSaved: () {},
                      controller: contactsController),
                  AppTextField(
                      label: "Address",
                      textInputType: TextInputType.text,
                      icon: const Icon(Icons.location_on),
                      onSaved: () {},
                      controller: addressController),
                  AppTextField(
                      label: "Description",
                      textInputType: TextInputType.text,
                      icon: const Icon(Icons.note_alt_rounded),
                      onSaved: () {},
                      controller: descriptionController),
                  BlocBuilder<ClinicsBloc, ClinicsState>(
                    builder: (context, state) {
                      if (state.status == ClinicsStatus.failed) {
                        return Text(
                          state.message,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                      return Container();
                    },
                  )
                ],
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              CreateClinicRequestDto request = CreateClinicRequestDto(
                name: nameController.text,
                address: addressController.text,
                contacts: contactsController.text,
                description: descriptionController.text,
              );

              context
                  .read<ClinicsBloc>()
                  .add(CreateClinic(context: context, request: request));
            },
            child: BlocConsumer<ClinicsBloc, ClinicsState>(
              listener: (context, state) {
                if (state.status == ClinicsStatus.success) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state.status == ClinicsStatus.loading) {
                  return const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return const Text("Save");
              },
            ),
          ),
        ],
      );
    },
  );
}

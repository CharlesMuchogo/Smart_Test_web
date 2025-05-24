import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/presentation/components/AppTextField.dart';

import '../../bloc/Results/results_bloc.dart';
import '../../domain/dto/test_results/update_test_tesults_dto.dart';
import '../../domain/models/test_results.dart';
import 'enums.dart';

void showEditResultsDialog(BuildContext context, TestResult result) {
  ResultStatus selectedResultStatus = ResultStatus.values.firstWhere(
    (e) => e.label == result.results,
    orElse: () => ResultStatus.Negative,
  );
  PartnerResult selectedPartnerResult = PartnerResult.values.firstWhere(
    (e) => e.label == result.partnerResults,
    orElse: () => PartnerResult.Negative,
  );

  ApprovalStatus selectedApprovalStatus = ApprovalStatus.values.firstWhere(
    (e) => e.label == (result.status),
    orElse: () => ApprovalStatus.Approved,
  );

  TextEditingController reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Edit Results"),
        content: SizedBox(
          width: min(MediaQuery.of(context).size.width * 0.6, 500),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDropdown<ResultStatus>(
                    context,
                    "Result",
                    selectedResultStatus,
                    ResultStatus.values,
                    (newValue) {
                      setState(() {
                        selectedResultStatus = newValue;
                      });
                    },
                  ),
                  _buildDropdown<PartnerResult>(
                    context,
                    "Partner Result",
                    selectedPartnerResult,
                    PartnerResult.values,
                    (newValue) {
                      setState(() {
                        selectedPartnerResult = newValue;
                      });
                    },
                  ),
                  _buildDropdown<ApprovalStatus>(
                    context,
                    "Status",
                    selectedApprovalStatus,
                    ApprovalStatus.values,
                    (newValue) {
                      setState(() {
                        selectedApprovalStatus = newValue;
                      });
                    },
                  ),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 12), child:  AppTextField(
                    label: "Reason",
                    textInputType: TextInputType.text,
                    icon: null,
                    maxLines: 5,
                    onSaved: (){},
                    controller: reasonController,
                  ))
                 ,
                  BlocBuilder<ResultsBloc, ResultsState>(
                    builder: (context, state) {
                      if (state.status == ResultsStatus.failed) {
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
              context.read<ResultsBloc>().add(UpdateTestResults(
                  context: context,
                  resultsDTO: UpdateTestResultsDTO(
                      uuid: result.uuid,
                      results: selectedResultStatus.name,
                      partnerResults: selectedPartnerResult.name,
                      reason: reasonController.text,
                      status: selectedApprovalStatus.name)));
            },
            child: BlocConsumer<ResultsBloc, ResultsState>(
              listener: (context, state) {
                if (state.status == ResultsStatus.success) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state.status == ResultsStatus.updating) {
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

Widget _buildDropdown<T>(
  BuildContext context,
  String label,
  T selectedValue,
  List<T> items,
  Function(T) onChanged,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        DropdownButton<T>(
          value: selectedValue,
          items: items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child:
                  Text(value.toString().split('.').last), // Show the enum label
            );
          }).toList(),
          onChanged: (T? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ],
    ),
  );
}

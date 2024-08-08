import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/Utils/utils.dart';
import 'package:smart_app/domain/models/test_results.dart';

import '../../bloc/Results/results_bloc.dart';
import '../components/CustomBox.dart';

class ResusltsPage extends StatelessWidget {
  const ResusltsPage({super.key});

  showImageDialog(BuildContext context, String title, String image) {
    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.6,
        child: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.none,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    context.read<ResultsBloc>().add(GetTestResults(context: context));

    return BlocBuilder<ResultsBloc, ResultsState>(
      builder: (context, state) {
        if (state.status == ResultsStatus.loading &&
            state.results.isEmpty) {
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
          return const CenteredColumn(content: Text("No results at the moment"));
        }

        List<TestResult> results = state.results.map((e) => TestResult.fromJson(e)).toList();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                  'Date',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'User',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Results',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Results Image',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Partner Results',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Results Image',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Care Option',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: results
                .asMap()
                .map(
                  (index, result) => MapEntry(
                index,
                DataRow(cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(result.date)),
                  DataCell(Text(
                      "${result.user.firstName} ${result.user.lastName}")),
                  DataCell(Text(result.results)),
                  DataCell(
                    result.results.isNotEmpty
                        ? GestureDetector(
                      onTap: () {
                        showImageDialog(
                            context,
                            "${result.user.firstName} Result",
                            mockImage1Url);
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl: mockImage1Url,
                              imageBuilder:
                                  (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) =>
                              const Center(
                                child: CircularProgressIndicator
                                    .adaptive(),
                              ),
                              errorWidget:
                                  (context, url, error) =>
                              const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 30,
                                ),
                              ),
                            )),
                      ),
                    )
                        : const Text("N/A"),
                  ),
                  DataCell(Text(result.partnerResults)),
                  DataCell(
                    result.partnerResults.isNotEmpty
                        ? GestureDetector(
                      onTap: () {
                        showImageDialog(
                            context,
                            "${result.user.firstName} partner result",
                            mockImageUrl);
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl: mockImageUrl,
                              imageBuilder:
                                  (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) =>
                              const Center(
                                child: CircularProgressIndicator
                                    .adaptive(),
                              ),
                              errorWidget:
                                  (context, url, error) =>
                              const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 30,
                                ),
                              ),
                            )),
                      ),
                    )
                        : const Text("N/A"),
                  ),
                  DataCell(
                    result.careOption != null
                        ? Text(result.careOption!)
                        : const Text("N/A"),
                  ),
                ]),
              ),
            )
                .values
                .toList(),
          ),
        );
      },
    );
  }
}

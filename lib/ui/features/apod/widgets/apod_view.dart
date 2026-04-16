import 'package:apod/domain/models/apod.dart';
import 'package:apod/ui/core/widgets/cosmos_waiting_indicator.dart';
import 'package:apod/ui/core/widgets/error_view.dart';
import 'package:apod/ui/features/apod/widgets/apod_result_view.dart';
import 'package:apod/ui/providers/apod_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApodView extends StatelessWidget {
  const ApodView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ApodWidget();
  }
}

class ApodWidget extends StatelessWidget {
  const ApodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final apodProvider = context.watch<ApodProvider>();
    return FutureBuilder<Apod>(
      key: ValueKey(apodProvider.apodFuture),
      future: apodProvider.apodFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorView(
            errorMessage:
                'An error occurred while fetching the APOD. Please try again later.',
            child: IconButton(
              onPressed: apodProvider.fetchApod,
              icon: const Icon(Icons.refresh),
            ),
          );
        } else if (snapshot.hasData) {
          return ApodResultView(apod: snapshot.data!);
        } else {
          return Center(
            child: CosmosWaitingIndicator(
              color: Theme.of(context).colorScheme.primary,
              size: 60,
            ),
          );
        }
      },
    );
  }
}

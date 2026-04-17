import 'package:apod/ui/core/widgets/cosmos_waiting_indicator.dart';
import 'package:apod/ui/core/widgets/messages.dart';
import 'package:apod/ui/features/apod_image_detail/widgets/apod_image_detail_view.dart';
import 'package:apod/ui/providers/apod_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApodImageDetailScreen extends StatelessWidget {
  static const routeName = '/apod-image-detail';

  const ApodImageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ApodImageDetailScreenArguments;
    final isDownloading = context.watch<ApodProvider>().isDownloading;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          isDownloading
              ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CosmosWaitingIndicator(
                    color: Colors.white,
                    size: 24,
                  ))
              : IconButton(
                  icon: const Icon(Icons.download_rounded, color: Colors.white),
                  onPressed: () async {
                    try {
                      await context
                          .read<ApodProvider>()
                          .downloadImage(args.imageUrl);
                      if (context.mounted) {
                        showSuccessToast(
                            'Image downloaded successfully', context);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showErrorToast('Failed to download image.', context);
                      }
                    }
                  },
                ),
        ],
      ),
      body: ApodImageDetailView(imageUrl: args.imageUrl),
    );
  }
}

class ApodImageDetailScreenArguments {
  final String imageUrl;

  ApodImageDetailScreenArguments({required this.imageUrl});
}

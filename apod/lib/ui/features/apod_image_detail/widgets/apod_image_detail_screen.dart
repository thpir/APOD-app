import 'package:apod/ui/features/apod_image_detail/view_model/apod_image_detail_view_model.dart';
import 'package:apod/ui/core/widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApodImageDetailScreen extends StatelessWidget {
  static const routeName = '/apod-image-detail';
  const ApodImageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apodImageUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              try {
                await context
                    .read<ApodImageDetailViewModel>()
                    .downloadImage(apodImageUrl);
                if (context.mounted) {
                  showSuccesSnackbar('Image downloaded succesfully', context);
                }
              } catch (e) {
                if (context.mounted) {
                  showErrorSnackbar('Failed to download image.', context);
                }
              }
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.network(apodImageUrl),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ApodImageDetailView extends StatefulWidget {
  const ApodImageDetailView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<ApodImageDetailView> createState() => _ApodImageDetailViewState();
}

class _ApodImageDetailViewState extends State<ApodImageDetailView> {
  final _transformationController = TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: GestureDetector(
        onDoubleTap: () =>
            _transformationController.value = Matrix4.identity(),
        child: InteractiveViewer(
          transformationController: _transformationController,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.network(
            widget.imageUrl,
            width: size.width,
            height: size.height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

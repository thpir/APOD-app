import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

void showSuccessToast(String message, BuildContext context) {
  shadcn.showToast(
    context: context,
    builder: (context, overlay) => shadcn.Alert(
      leading: const Icon(Icons.check_circle_outline),
      title: Text(message),
    ),
  );
}

void showErrorToast(String message, BuildContext context) {
  shadcn.showToast(
    context: context,
    builder: (context, overlay) => shadcn.Alert.destructive(
      leading: const Icon(Icons.error_outline),
      title: Text(message),
    ),
  );
}

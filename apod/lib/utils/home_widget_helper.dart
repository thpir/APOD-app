import 'package:apod/models/apod.dart';
import 'package:home_widget/home_widget.dart';

class HomeWidgetHelper {
  static String appGroupId = 'apodapp';
  static String androidWidgetName = 'ApodWidget';

  void updateWidget(Apod newApod) {
    HomeWidget.setAppGroupId(appGroupId);
    HomeWidget.saveWidgetData<String>('title', newApod.title);
    HomeWidget.saveWidgetData<String>('mediaType', newApod.mediaType);
    HomeWidget.saveWidgetData<String>('url', newApod.url);
    HomeWidget.updateWidget(
      androidName: androidWidgetName,
    );
  }
}
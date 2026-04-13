import 'package:apod/domain/models/apod.dart';
import 'package:home_widget/home_widget.dart';

class HomeWidgetHelper {
  static var appGroupId = 'apodapp';
  static var androidWidgetName = 'ApodWidget';

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
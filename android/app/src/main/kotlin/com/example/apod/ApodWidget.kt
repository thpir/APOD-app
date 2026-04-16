package com.example.apod

import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetReceiver

class ApodWidget : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = ApodGlanceWidget()
}

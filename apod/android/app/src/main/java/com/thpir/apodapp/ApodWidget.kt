package com.thpir.apodapp

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import com.bumptech.glide.Glide
import com.bumptech.glide.annotation.GlideModule
import com.bumptech.glide.module.AppGlideModule
import com.bumptech.glide.request.target.AppWidgetTarget
import es.antonborri.home_widget.HomeWidgetPlugin

@GlideModule
class MyAppGlideModule : AppGlideModule()

class ApodWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val widgetData = HomeWidgetPlugin.getData(context)
        updateAppWidget(context, appWidgetManager, appWidgetIds[0], widgetData)
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
    private fun updateAppWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        widgetData: SharedPreferences
    ) {
        // Get the data from dart
        val imageUrl = widgetData.getString("url", null)
        val imageTitle = widgetData.getString("title", "")
        // Construct the RemoteViews object
        val remoteViews = RemoteViews(context.packageName, R.layout.apod_widget).apply {
            setTextViewText(R.id.apod_title, imageTitle ?: "No APOD available")
        }
        val appWidgetTarget = AppWidgetTarget(context, R.id.apod_image, remoteViews, appWidgetId)

        if (!imageUrl.isNullOrEmpty()) {
            // Only parse and load if imageUrl is valid
            Glide.with(context.applicationContext)
                .asBitmap()
                .load(Uri.parse(imageUrl))
                .placeholder(R.drawable.ic_launcher_background)
                .into(appWidgetTarget)
        } else {
            Glide.with(context.applicationContext)
                .asBitmap()
                .load(R.drawable.ic_launcher_background)
                .into(appWidgetTarget)
        }

        appWidgetManager.updateAppWidget(appWidgetId, remoteViews)
    }
}
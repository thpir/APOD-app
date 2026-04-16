package com.example.apod

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.ContentScale
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.padding
import androidx.glance.state.GlanceStateDefinition
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import android.content.Intent
import androidx.glance.LocalContext
import androidx.glance.action.clickable
import androidx.glance.appwidget.action.actionStartActivity
import coil.imageLoader
import coil.request.ImageRequest
import coil.request.SuccessResult

class ApodGlanceWidget : GlanceAppWidget() {

    override val stateDefinition: GlanceStateDefinition<*>? = null

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        val url = prefs.getString("url", null)
        val title = prefs.getString("title", null) ?: ""
        val bitmap = url?.let { loadNetworkImage(context, it) } ?: loadPlaceholder(context)

        provideContent {
            ApodContent(title = title, bitmap = bitmap)
        }
    }

    private suspend fun loadNetworkImage(context: Context, url: String): Bitmap? {
        return try {
            val request = ImageRequest.Builder(context)
                .data(url)
                .allowHardware(false)
                .build()
            val result = context.imageLoader.execute(request)
            if (result is SuccessResult) {
                (result.drawable as? BitmapDrawable)?.bitmap
            } else null
        } catch (e: Exception) {
            null
        }
    }

    private fun loadPlaceholder(context: Context): Bitmap? {
        return try {
            context.assets.open("flutter_assets/images/stars.png").use { stream ->
                BitmapFactory.decodeStream(stream)
            }
        } catch (e: Exception) {
            null
        }
    }
}

@Composable
private fun ApodContent(title: String, bitmap: Bitmap?) {
    val context = LocalContext.current
    Box(
        modifier = GlanceModifier
            .fillMaxSize()
            .background(Color.Black)
            .clickable(actionStartActivity(Intent(context, MainActivity::class.java))),
        contentAlignment = Alignment.BottomCenter,
    ) {
        if (bitmap != null) {
            Image(
                provider = ImageProvider(bitmap),
                contentDescription = title,
                contentScale = ContentScale.Crop,
                modifier = GlanceModifier.fillMaxSize(),
            )
        }
        if (title.isNotEmpty()) {
            Box(
                modifier = GlanceModifier
                    .fillMaxWidth()
                    .background(Color(red = 0f, green = 0f, blue = 0f, alpha = 0.6f))
                    .padding(12.dp),
            ) {
                Text(
                    text = title,
                    style = TextStyle(
                        color = ColorProvider(Color.White),
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Bold,
                    ),
                    maxLines = 2,
                )
            }
        }
    }
}

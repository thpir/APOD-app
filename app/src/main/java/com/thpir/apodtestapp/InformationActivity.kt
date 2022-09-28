package com.thpir.apodtestapp

import android.os.Bundle
import android.view.View
import android.webkit.WebSettings
import android.webkit.WebView
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide

class InformationActivity : AppCompatActivity() {

    private lateinit var imageviewApod: ImageView
    private lateinit var relativelayoutApod: RelativeLayout
    private lateinit var webviewApod: WebView
    private lateinit var textviewTitle: TextView
    private lateinit var textviewDate: TextView
    private lateinit var textviewDescription: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_information)
        // Set the toolbar
        setSupportActionBar(findViewById(R.id.my_toolbar))
        // Enable the Up button
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        // Get the values passed from the MainActivity
        val apodUrl = intent.getStringExtra("url")
        val apodTitleText= intent.getStringExtra("title")
        val apodDateText = intent.getStringExtra("date")
        val apodDescriptionText = intent.getStringExtra("description")
        val apodMediaType = intent.getStringExtra("type")

        // Initialize the textviews and imageview
        imageviewApod = findViewById(R.id.imageviewApod)
        relativelayoutApod = findViewById(R.id.relativelayout_webview)
        webviewApod = findViewById(R.id.webview_apod)
        textviewTitle = findViewById(R.id.textviewTitle)
        textviewDate = findViewById(R.id.textviewDate)
        textviewDescription = findViewById(R.id.textviewDescription)

        if (apodMediaType == "image") {
            relativelayoutApod.visibility = View.GONE
            webviewApod.visibility = View.GONE
            imageviewApod.visibility = View.VISIBLE
            // Set data to the textviews and imageview
            Glide.with(this)
                .asDrawable()
                .load(apodUrl)
                .into(imageviewApod)
        } else {
            // Hide the imageview and set the webview to visible
            relativelayoutApod.visibility = View.VISIBLE
            webviewApod.visibility = View.VISIBLE
            imageviewApod.visibility = View.GONE
            // Load the URL and enable the webChromeClient and JavaScript to access Youtube
            webviewApod.webViewClient
            val apodVideo = apodUrl.toString()
            webviewApod.loadUrl(apodVideo)
            webviewApod.webChromeClient
            val webSettings: WebSettings = webviewApod.settings
            webSettings.javaScriptEnabled = true
            webSettings.pluginState = WebSettings.PluginState.ON
        }

        val title = "Title: $apodTitleText"
        val date = "Date: $apodDateText"
        val description = "Description: $apodDescriptionText"
        textviewTitle.text = title
        textviewDate.text = date
        textviewDescription.text = description
    }
}
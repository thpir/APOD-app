package com.thpir.apodtestapp

import android.content.Context
import android.content.Intent
import android.graphics.drawable.ColorDrawable
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.webkit.WebSettings
import android.webkit.WebView
import android.widget.ImageView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.bumptech.glide.Glide

class MainActivity : AppCompatActivity() {

    private lateinit var imageviewApod: ImageView
    private lateinit var webviewApod: WebView
    private lateinit var toolbar: Toolbar
    private var apiURL: String = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
    private lateinit var apodUrl: String
    private lateinit var apodTitleText: String
    private lateinit var apodDateText: String
    private lateinit var apodDescriptionText: String
    private lateinit var apodType: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Set the toolbar
        setSupportActionBar(findViewById(R.id.my_toolbar))

        //Create full screen view
        hideSystemBars()

        // initialize the imageview & videoview
        imageviewApod = findViewById(R.id.imageview_apod)
        webviewApod = findViewById(R.id.webview_apod)
        toolbar = findViewById(R.id.my_toolbar)

        // Check if internet is available.
        // Send a get request to the APOD API and extract values from the JSON that was returned.
        if (isInternetAvailable()) {
            sendRequest();
        } else {
            Toast.makeText(this, "No internet connection available...", Toast.LENGTH_SHORT).show()
        }
    }

    private fun isInternetAvailable(): Boolean {
        // register activity with the connectivity manager service
        val connectivityManager = this.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        // Returns a Network object corresponding to
        // the currently active default data network.
        val network = connectivityManager.activeNetwork ?: return false

        // Representation of the capabilities of an active network.
        val activeNetwork = connectivityManager.getNetworkCapabilities(network) ?: return false

        return when {
            // Indicates this network uses a Wi-Fi transport,
            // or WiFi has network connectivity
            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true

            // Indicates this network uses a Cellular transport. or
            // Cellular has network connectivity
            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true

            // else return false
            else -> false
        }
    }

    private fun sendRequest() {
        val queue = Volley.newRequestQueue(this)
        val jsonObjectRequest = JsonObjectRequest(Request.Method.GET, apiURL, null, {response ->
            val apodTitle = response.getString("title")
            apodTitleText = apodTitle.toString()
            val apodDate = response.getString("date")
            apodDateText = apodDate.toString()
            val apodDescription = response.getString("explanation")
            apodDescriptionText = apodDescription.toString()
            val apodImage = response.getString("url")
            apodUrl = apodImage.toString()
            val apodMediaType = response.getString("media_type")
            apodType = apodMediaType.toString()
            // Sometimes the API returns no hdurl (when APOD type is a video)
            if (apodType == "image") {
                // Hide the webview and set the imageview to visible
                webviewApod.visibility = View.GONE
                imageviewApod.visibility = View.VISIBLE
                val apodHdImage = response.getString("hdurl")
                Glide.with(this)
                    .asDrawable()
                    .load(apodHdImage)
                    .placeholder(R.drawable.loading)
                    .error(R.drawable.error_loading)
                    .into(imageviewApod)
            } else {
                // Change the actionbar color to black to prevent overlaying text
                supportActionBar!!.setBackgroundDrawable(ColorDrawable(resources.getColor(R.color.black)))
                // Hide the imageview and set the webview to visible
                webviewApod.visibility = View.VISIBLE
                imageviewApod.visibility = View.GONE
                // Load the URL and enable the webChromeClient and JavaScript to access Youtube
                webviewApod.webViewClient
                webviewApod.loadUrl(apodUrl)
                webviewApod.webChromeClient
                val webSettings: WebSettings = webviewApod.settings
                webSettings.javaScriptEnabled = true
                webSettings.pluginState = WebSettings.PluginState.ON
            }
        },{
            Toast.makeText(this,"Something Went Wrong",Toast.LENGTH_SHORT).show()
        })
        queue.add(jsonObjectRequest)
    }


    // Create the options menu
    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.main_menu, menu)
        return true
    }

    // Set an action to the options menu
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Open the information activity and pass data to it
        if (item.itemId == R.id.action_information) {
            if (isInternetAvailable()) {
                val intent = Intent(this, InformationActivity::class.java).apply {
                    // pass APOD data
                    putExtra("title", apodTitleText)
                    putExtra("date", apodDateText)
                    putExtra("url", apodUrl)
                    putExtra("description", apodDescriptionText)
                    putExtra("type", apodType)
                }
                startActivity(intent)
                return true
            } else {
                Toast.makeText(this, "No internet connection available...", Toast.LENGTH_SHORT).show()
            }
        } else if (item.itemId == R.id.action_refresh) {
            if (isInternetAvailable()) {
                sendRequest();
                Toast.makeText(this, "Page reloaded", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, "No internet connection available...", Toast.LENGTH_SHORT).show()
            }
        }

        return super.onOptionsItemSelected(item)
    }

    // Enable full screen mode
    private fun hideSystemBars() {
        // source on how to hide the system bars: https://developer.android.com/develop/ui/views/layout/immersive
        val windowInsetsController =
            ViewCompat.getWindowInsetsController(window.decorView) ?: return
        // Configure the behavior of the hidden system bars
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        // Hide both the status bar and the navigation bar
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
    }
}
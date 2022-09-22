package com.thpir.apodtestapp

import android.os.Bundle
import android.widget.ImageView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.bumptech.glide.Glide

class MainActivity : AppCompatActivity() {

    private lateinit var imageviewApod: ImageView
    private var apiURL: String = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //Create full screen view
        hideSystemBars()

        // initialize the imageview
        imageviewApod = findViewById(R.id.imageview_apod)

        val queue = Volley.newRequestQueue(this)
        val jsonObjectRequest = JsonObjectRequest(Request.Method.GET, apiURL, null, {response ->
            val apodTitle = response.getString("title")
            //textviewTitle.text = apodTitle.toString()
            val apodDate = response.getString("date")
            //textviewDate.text = apodDate.toString()
            val apodDescription = response.getString("explanation")
            //textviewDescription.text = apodDescription.toString()
            val apodImage = response.getString("url")
            val apodHdImage=response.getString("hdurl")
            Glide.with(this)
                .asDrawable()
                .load(apodHdImage)
                .into(imageviewApod)
        },{
            Toast.makeText(this,"Something Went Wrong",Toast.LENGTH_SHORT).show()
        })
        queue.add(jsonObjectRequest)

    }

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
package com.thpir.apodtestapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import android.widget.TextView
import com.bumptech.glide.Glide

class InformationActivity : AppCompatActivity() {

    private lateinit var imageviewApod: ImageView
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
        textviewTitle = findViewById(R.id.textviewTitle)
        textviewDate = findViewById(R.id.textviewDate)
        textviewDescription = findViewById(R.id.textviewDescription)

        // Set data to the textviews and imageview
        Glide.with(this)
            .asDrawable()
            .load(apodUrl)
            .into(imageviewApod)
        val title = "Title: $apodTitleText"
        val date = "Date: $apodDateText"
        val description = "Description: $apodDescriptionText"
        textviewTitle.text = title
        textviewDate.text = date
        textviewDescription.text = description
    }
}
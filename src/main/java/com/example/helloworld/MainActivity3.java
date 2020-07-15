package com.example.helloworld;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ProgressBar;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity3 extends AppCompatActivity {
    ProgressBar progressBar;
    ImageView bosKovan;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);
        ImageButton bumblebeeButton = (ImageButton) findViewById(R.id.bumblebeeButton);
        bosKovan=(ImageView) findViewById(R.id.bosKovan);
        progressBar= (ProgressBar) findViewById(R.id.progressBar);

        bumblebeeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                progressBar.setProgress(progressBar.getProgress()+1);
                if(progressBar.getMax()==progressBar.getProgress())
                    bosKovan.setImageResource(R.drawable.bos_kovan);
            }
        });
    }
}

/*
public class MainActivity3 extends AppCompatActivity {

    ImageButton bumblebeeButton = (ImageButton) findViewById(R.id.bumblebeeButton);
        ImageView bosKovan=(ImageView) findViewById(R.id.bosKovan);
        ProgressBar progressBar= (ProgressBar) findViewById(R.id.progressBar);

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main3);

            if(progressBar.getMax()==progressBar.getProgress())
                bosKovan.setImageResource(R.drawable.bos_kovan);

            bumblebeeButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    progressBar.setProgress(progressBar.getProgress()+1);
                }
            });
    }
}
 */
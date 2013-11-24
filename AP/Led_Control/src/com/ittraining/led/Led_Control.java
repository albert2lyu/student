package com.ittraining.led;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

public class Led_Control extends Activity {
	
	private final int led_on = 1;
	private final int led_off = 2;
	
	private ImageView imageLeft;
	private ImageView imageRight;
	private Button button;
	
	public int stateLeft = 0, stateRight = 0;
	public int fd = 0;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		
		findView();
		
		// 開啟LED裝置
		fd = Linuxc.openled();
		

		if (fd < 0) {
			Toast.makeText(Led_Control.this, "open device false!", Toast.LENGTH_SHORT).show();
			
			finish();
		} else {
			Toast.makeText(Led_Control.this, "open device success!", Toast.LENGTH_SHORT).show();
		}
		
		setListener();
	}
	
	private void findView() {
		imageLeft = (ImageView) findViewById(R.id.imageLeft);
		imageRight = (ImageView) findViewById(R.id.imageRight);
		button = (Button) findViewById(R.id.button);
	}
	
	private void setListener() {
		imageLeft.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				if (stateLeft == 0) {
					imageLeft.setImageResource(R.drawable.light);
					stateLeft = 1;
					Linuxc.send(1, led_on);
					
				} else if (stateLeft == 1) {
					imageLeft.setImageResource(R.drawable.dark);
					stateLeft = 0;
					Linuxc.send(1, led_off);
				}
			}
		});
		
		imageRight.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				if (stateRight == 0) {
					imageRight.setImageResource(R.drawable.light);
					stateRight = 1;
					Linuxc.send(2, led_on);
				} else if (stateRight == 1) {
					imageRight.setImageResource(R.drawable.dark);
					stateRight = 0;
					Linuxc.send(2, led_off);
				}
			}
		});
		
		button.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				
				// 關閉LED裝置
				Linuxc.closeled();
				
				Toast.makeText(Led_Control.this, "close device success!", Toast.LENGTH_SHORT).show();

				finish();
			}
		});
	}
}
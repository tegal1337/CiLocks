package io.kos.antiguard;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.app.KeyguardManager;
import android.app.KeyguardManager.KeyguardLock;
import android.content.Intent;
import android.content.Context;
import android.content.ComponentName;
import android.net.Uri;


public class unlock extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {

	KeyguardManager keyguardManager = (KeyguardManager) getSystemService(Context.KEYGUARD_SERVICE);
	KeyguardLock mkeyguardLock = keyguardManager.newKeyguardLock("unlock");
	mkeyguardLock.disableKeyguard();



        super.onCreate(savedInstanceState);

        setContentView(R.layout.main);

        // Button to go to the page the user was last looking at
        Button backButton = (Button) findViewById(R.id.backButton);
        backButton.setOnClickListener(new OnClickListener() {
        	  public void onClick(View v) {
                          back();
        	  }
        	});

        // Button to go directly to the default launcher
        Button launcherButton = (Button) findViewById(R.id.launcherButton);
        launcherButton.setOnClickListener(new OnClickListener() {
        	  public void onClick(View v) {
                          viewLauncher();
        	  }
                });

        // Button to go directly to the Development options
        Button developmentButton = (Button) findViewById(R.id.developmentButton);
        developmentButton.setOnClickListener(new OnClickListener() {
        	  public void onClick(View v) {
                          viewDevelopmentSettings();
        	  }
                });

        // Button to UNINSTALL app
        Button uninstallButton = (Button) findViewById(R.id.uninstallButton);
        uninstallButton.setOnClickListener(new OnClickListener() {
        	  public void onClick(View v) {
                          promptUninstall();
        	  }
                });


    }

    public void viewLauncher(){
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        startActivity(intent);
    }

    public void back(){
        finish();
    }

    public void viewDevelopmentSettings(){
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.setComponent(ComponentName.unflattenFromString("com.android.settings/.DevelopmentSettings"));
        intent.addCategory("android.intent.category.LAUNCHER");
        startActivity(intent);
    }

    public void promptUninstall(){
        Uri packageUri = Uri.parse("package:io.kos.antiguard");
        Intent uninstallIntent = new Intent(Intent.ACTION_DELETE, packageUri);
        startActivity(uninstallIntent);
    }


}

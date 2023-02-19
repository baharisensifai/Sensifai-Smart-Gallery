package com.sensifai.smart_gallery

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import androidx.core.content.pm.PackageInfoCompat
import androidx.multidex.MultiDex
import com.google.android.gms.common.GoogleApiAvailability
import com.judemanutd.autostarter.AutoStartPermissionHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "sg.sensifai.dev/auto-start"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getAutoStartAccess") {
                val status: Boolean = AutoStartPermissionHelper.getInstance().getAutoStartPermission(context, open = true, newTask = true)
                when (Build.BRAND.lowercase()){
                    "samsung" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N){
                            val intent: Intent = Intent().setComponent(ComponentName("com.samsung.android.lool", "com.samsung.android.sm.ui.battery.BatteryActivity"))
                            startActivity(intent)
                        }
                    }
                    "honor" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N){
//                            val intent: Intent? = packageManager.getLaunchIntentForPackage("com.huawei.systemmanager")
//                            startActivity(intent)
                            startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS))
                        } else {
                            val intent: Intent = Intent().setComponent(ComponentName("com.huawei.systemmanager",
                                "com.huawei.systemmanager.optimize.process.ProtectActivity"))
                            startActivity(intent)
                        }

                    }
                }
                result.success("true")
            } else if (call.method == "getGMSVersion"){
                val v: Long = PackageInfoCompat.getLongVersionCode(
                    packageManager.getPackageInfo(
                        GoogleApiAvailability.GOOGLE_PLAY_SERVICES_PACKAGE,
                        0
                    )
                )
                result.success(v)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }


}

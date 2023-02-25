package com.sensifai.smart_gallery

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.provider.Telephony.Mms.Intents
import androidx.core.content.pm.PackageInfoCompat
import androidx.multidex.MultiDex
import com.google.android.gms.common.GoogleApiAvailability
import com.judemanutd.autostarter.AutoStartPermissionHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val channel = "sg.sensifai.dev/sg"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAutoStartAccess" -> {
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
                                startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS))
                            } else {
                                val intent: Intent = Intent().setComponent(ComponentName("com.huawei.systemmanager",
                                    "com.huawei.systemmanager.optimize.process.ProtectActivity"))
                                startActivity(intent)
                            }

                        }
                    }
                    result.success("true")
                }
                "getGMSVersion" -> {
                    val v: Long = PackageInfoCompat.getLongVersionCode(
                        packageManager.getPackageInfo(
                            GoogleApiAvailability.GOOGLE_PLAY_SERVICES_PACKAGE,
                            0
                        )
                    )
                    result.success(v)
                }
                "open" -> {
                    val url: String? = call.argument<String>("url")
                    if (url != null){
                        val intent: Intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                        startActivity(intent)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }


}

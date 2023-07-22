package com.example.flutter_platform_code

import android.content.Context
import android.database.Cursor
import android.media.RingtoneManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        var channel1 = "flutter_channel"
        var channel2 = "toastBar"
        var channel3 = "ChangeColor"
        var channel4 = "samples.flutter.dev/battery"
        fun getBatteryLevel(): Int {
            val batteryLevel: Int
            if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
                val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            } else {
                val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            }

            return batteryLevel
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel1)
                .setMethodCallHandler { call, result ->
                    when(call.method){
                        "getRingtones" -> {
                            val ringtones = getAllRingtones(this)
                            result.success(ringtones)
                        }
                    }
                }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel2)
                .setMethodCallHandler { call, result ->
                   if(call.method == "ShowToastBar"){
                       Toast.makeText(this,"Вызвали Toast", Toast.LENGTH_LONG).show();
                   }
                }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel3)
                .setMethodCallHandler { call, result ->
                    if(call.method == "ChangeBackgorundColor"){
                        result.success("0xff60e950");
                    }
                }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel4).setMethodCallHandler {
            // This method is invoked on the main thread.
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }


private fun getAllRingtones(context: Context): List<String>{
        val manager = RingtoneManager(context)
        manager.setType(RingtoneManager.TYPE_RINGTONE)

        val cursor : Cursor = manager.cursor

        val list : MutableList<String> = mutableListOf()
        while(cursor.moveToNext()){
            val notificationTitle : String = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX)
            list.add(notificationTitle)
        }
        return list
    }
}

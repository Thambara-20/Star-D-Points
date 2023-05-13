package com.example.star_points_radeem

import io.flutter.embedding.android.FlutterActivity

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.telephony.SmsManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "send_sms"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "send") {
                val address = call.argument<String>("address")
                val message = call.argument<String>("message")
                try {
                    val smsManager = SmsManager.getDefault()
                    smsManager.sendTextMessage(address, null, message, null, null)
                    result.success(true)
                } catch (e: Exception) {
                    result.error("SEND_SMS_ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
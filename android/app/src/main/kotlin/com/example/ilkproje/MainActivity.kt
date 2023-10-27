package com.example.ilkproje

import io.flutter.embedding.android.FlutterActivity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class CallEndedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent == null) {
            // Eğer context veya intent null ise, burada işlem yapabilirsiniz.
            // Örneğin:
            Log.d("CallEndedReceiver", "context veya intent null geldi")
        } else {
            // Eğer context ve intent null değilse, uygulamayı başlatın.
            val launchIntent = Intent(context, MainActivity::class.java)
            launchIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            context.startActivity(launchIntent)
            // Arama sonlandığında yapılması gereken işlemleri burada gerçekleştirin
        }
    }
}
class MainActivity : FlutterActivity() {
}

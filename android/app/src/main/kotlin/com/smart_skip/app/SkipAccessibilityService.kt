package com.smart_skip.app

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import android.widget.Toast
import android.os.Handler
import android.os.Looper

class SkipAccessibilityService : AccessibilityService() {

    private val handler = Handler(Looper.getMainLooper())
    private var lastSkipTimestamp = 0L
    private val SKIP_DEBOUNCE_MS = 2500L // evita clics repetidos en menos de 2.5s

    override fun onServiceConnected() {
        super.onServiceConnected()
        val info = AccessibilityServiceInfo().apply {
            eventTypes = AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED or
                         AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED or
                         AccessibilityEvent.TYPE_VIEW_CLICKED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            flags = AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS or
                    AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
            packageNames = arrayOf(
                "com.google.android.youtube",
                "com.google.android.apps.youtube.music",
                "com.facebook.katana",
                "com.android.chrome"
            )
        }
        serviceInfo = info
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        try {
            val now = System.currentTimeMillis()
            if (now - lastSkipTimestamp < SKIP_DEBOUNCE_MS) return

            val root = rootInActiveWindow ?: return

            val keywords = listOf("Skip", "Omitir")
            val matches = ArrayList<AccessibilityNodeInfo>()

            for (keyword in keywords) {
                val found = root.findAccessibilityNodeInfosByText(keyword)
                if (!found.isNullOrEmpty()) {
                    matches.addAll(found)
                }
            }

            if (matches.isNotEmpty()) {
                for (node in matches) {
                    if (attemptClick(node)) {
                        lastSkipTimestamp = now
                        showToast("Anuncio omitido")
                        break
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun attemptClick(node: AccessibilityNodeInfo): Boolean {
        if (node.isClickable) {
            return node.performAction(AccessibilityNodeInfo.ACTION_CLICK)
        } else {
            var parent = node.parent
            while (parent != null) {
                if (parent.isClickable) {
                    return parent.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                }
                parent = parent.parent
            }
        }
        return false
    }

    override fun onInterrupt() {}

    private fun showToast(text: String) {
        handler.post {
            Toast.makeText(applicationContext, text, Toast.LENGTH_SHORT).show()
        }
    }
}

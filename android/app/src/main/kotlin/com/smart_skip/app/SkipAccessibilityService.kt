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
            // opcional: limitar a YouTube
            // packageNames = arrayOf("com.google.android.youtube")
        }
        serviceInfo = info
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        try {
            val now = System.currentTimeMillis()
            if (now - lastSkipTimestamp < SKIP_DEBOUNCE_MS) return

            val root = rootInActiveWindow ?: return
            val matches = root.findAccessibilityNodeInfosByText("Skip")

            if (matches != null && matches.isNotEmpty()) {
                for (node in matches) {
                    if (node.isClickable) {
                        if (node.performAction(AccessibilityNodeInfo.ACTION_CLICK)) {
                            lastSkipTimestamp = now
                            showToast("Anuncio omitido")
                            break
                        }
                    } else {
                        var parent = node.parent
                        while (parent != null) {
                            if (parent.isClickable) {
                                if (parent.performAction(AccessibilityNodeInfo.ACTION_CLICK)) {
                                    lastSkipTimestamp = now
                                    showToast("Anuncio omitido")
                                    break
                                }
                            }
                            parent = parent.parent
                        }
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun onInterrupt() {}

    private fun showToast(text: String) {
        handler.post {
            Toast.makeText(applicationContext, text, Toast.LENGTH_SHORT).show()
        }
    }
}

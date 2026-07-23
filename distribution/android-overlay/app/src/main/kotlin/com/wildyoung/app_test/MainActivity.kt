package com.wildyoung.app_test

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import com.google.firebase.appdistribution.FirebaseAppDistribution
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private var updateCheckInProgress = false

    override fun onResume() {
        super.onResume()

        if (requestNotificationPermissionIfNeeded()) {
            return
        }

        checkForAppDistributionUpdate()
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if (requestCode == NOTIFICATION_PERMISSION_REQUEST_CODE) {
            checkForAppDistributionUpdate()
        }
    }

    private fun requestNotificationPermissionIfNeeded(): Boolean {
        if (
            Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU ||
                checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) ==
                PackageManager.PERMISSION_GRANTED
        ) {
            return false
        }

        val preferences = getSharedPreferences(PREFERENCES_NAME, MODE_PRIVATE)
        if (preferences.getBoolean(NOTIFICATION_PERMISSION_REQUESTED, false)) {
            return false
        }

        preferences.edit().putBoolean(NOTIFICATION_PERMISSION_REQUESTED, true).apply()
        requestPermissions(
            arrayOf(Manifest.permission.POST_NOTIFICATIONS),
            NOTIFICATION_PERMISSION_REQUEST_CODE,
        )
        return true
    }

    private fun checkForAppDistributionUpdate() {
        if (updateCheckInProgress) {
            return
        }

        updateCheckInProgress = true
        FirebaseAppDistribution.getInstance()
            .updateIfNewReleaseAvailable()
            .addOnFailureListener { error ->
                Log.w(TAG, "Firebase App Distribution update check failed.", error)
            }.addOnCompleteListener {
                updateCheckInProgress = false
            }
    }

    private companion object {
        const val TAG = "AppDistributionUpdate"
        const val NOTIFICATION_PERMISSION_REQUEST_CODE = 1001
        const val PREFERENCES_NAME = "app_distribution_preferences"
        const val NOTIFICATION_PERMISSION_REQUESTED = "notification_permission_requested"
    }
}

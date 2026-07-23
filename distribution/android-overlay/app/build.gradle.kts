plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    // The Flutter Gradle Plugin must be applied after the Android Gradle plugin.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.wildyoung.app_test"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.wildyoung.app_test"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "distribution"
    productFlavors {
        create("firebase") {
            dimension = "distribution"
        }
    }

    buildTypes {
        release {
            // This test app keeps using the repository's cached debug key so
            // Firebase builds can update one another on tester devices.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    // API calls compile in every variant, but self-update is bundled only in
    // the Firebase pre-release flavor and must not be shipped to Google Play.
    implementation("com.google.firebase:firebase-appdistribution-api:16.0.0-beta20")
    add(
        "firebaseImplementation",
        "com.google.firebase:firebase-appdistribution:16.0.0-beta20",
    )
}

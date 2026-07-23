#!/usr/bin/env bash
set -euo pipefail

settings_file="android/settings.gradle.kts"
overlay_dir="distribution/android-overlay"

if [[ ! -f "$settings_file" ]]; then
  echo "Generated Android settings file was not found: $settings_file" >&2
  exit 1
fi

if ! grep -Fq 'id("com.google.gms.google-services")' "$settings_file"; then
  temporary_settings="$(mktemp)"
  awk '
    { print }
    /id\("com.android.application"\) version/ {
      print "    id(\"com.google.gms.google-services\") version \"4.5.0\" apply false"
      inserted += 1
    }
    END {
      if (inserted != 1) {
        exit 1
      }
    }
  ' "$settings_file" > "$temporary_settings"
  mv "$temporary_settings" "$settings_file"
fi

cp -R "$overlay_dir/." android/

grep -Fq 'id("com.google.gms.google-services")' "$settings_file"
test -f android/app/google-services.json
test -f android/app/src/main/kotlin/com/wildyoung/app_test/MainActivity.kt

#!/bin/bash

# Function for styled logging
log() {
    local color=$1
    local message=$2
    case $color in
        "green") echo -e "\033[32m$message\033[0m" ;;
        "blue") echo -e "\033[34m$message\033[0m" ;;
        "red") echo -e "\033[31m$message\033[0m" ;;
    esac
}

# Print header
log "blue" "======================================"
log "blue" "  Generating Android Debug APK"
log "blue" "======================================"
echo

# Bundle React Native app
log "green" "📦 Bundling React Native app..."
npx react-native bundle \
    --platform android \
    --dev false \
    --entry-file index.js \
    --bundle-output android/app/src/main/assets/index.android.bundle \
    --assets-dest android/app/src/main/res

if [ $? -eq 0 ]; then
    log "green" "✅ Bundle created successfully!"
else
    log "red" "❌ Bundle creation failed!"
    exit 1
fi

echo

# Clean and Build Android debug APK
cd android/

log "green" "🧹 Cleaning Android build..."
./gradlew clean

if [ $? -eq 0 ]; then
    log "green" "✅ Clean completed successfully!"
else
    log "red" "❌ Clean failed!"
    exit 1
fi

echo

log "green" "🔨 Building Android debug APK..."
./gradlew assembleDebug

if [ $? -eq 0 ]; then
    log "green" "✅ Debug APK built successfully!"
    log "blue" "📱 APK location: android/app/build/outputs/apk/debug/app-debug.apk"
else
    log "red" "❌ Debug APK build failed!"
    exit 1
fi

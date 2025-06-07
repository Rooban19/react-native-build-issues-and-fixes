#!/bin/bash

KEYSTORE_PATH="$(pwd)/keystore/keystore"

echo "Enter Keystore Alias:"
read KEY_ALIAS

echo "Enter Keystore Password:"
read -s STORE_PASS

echo "Enter Key Password:"
read -s KEY_PASS

# Run keytool to get the SHA-1 fingerprint
keytool -list -v \
  -keystore "$KEYSTORE_PATH" \
  -alias "$KEY_ALIAS" \
  -storepass "$STORE_PASS" \
  -keypass "$KEY_PASS" | grep "SHA1:"

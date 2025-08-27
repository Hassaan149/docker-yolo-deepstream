#!/bin/sh

# Substitute environment variable into the template
envsubst < deepstream_app_config_temp.txt > deepstream_app_config.txt

echo "======= Final Config ========="
cat deepstream_app_config.txt
echo "=============================="

exec deepstream-app -c deepstream_app_config.txt

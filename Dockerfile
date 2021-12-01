from ubuntu:20.04

arg ANDROID_SDK_VERSION=7583922_latest
arg ANDROID_SDK_SHA256=124f2d5115eee365df6cf3228ffbca6fc3911d16f8025bebd5b1c6e2fcfa7faf

env DEBIAN_FRONTEND=noninteractive
env ANDROID_SDK_ROOT=/opt/android-sdk
env PATH=${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:$PATH

run apt-get update \
    && apt-get -qq upgrade \
    && apt-get -qq install \
      curl \
      git \
      openjdk-11-jdk-headless \
      unzip \
      wget \
    && apt-get -qq autoremove \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

run TMP=/tmp/android-sdk.zip \
    ;  DST=$ANDROID_SDK_ROOT/cmdline-tools \
    ;  wget --quiet -O $TMP https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}.zip \
    && echo "${ANDROID_SDK_SHA256} ${TMP}" | sha256sum -c \
    && unzip -qq -d /tmp $TMP \
    && mkdir -p $DST \
    && mv /tmp/cmdline-tools $DST/latest \
    && yes | sdkmanager --licenses > /dev/null 2>&1

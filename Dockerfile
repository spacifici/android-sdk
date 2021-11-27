from ubuntu:20.04

env DEBIAN_FRONTEND=noninteractive

run apt-get update \
    && apt-get -qq upgrade \
    && apt-get -qq install \
      git \
      openjdk-11-jdk-headless \
      unzip \
      wget \
    && apt-get -qq autoremove \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

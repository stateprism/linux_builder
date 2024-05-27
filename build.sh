#!/usr/bin/env bash
# -*- coding: utf-8 -*-

cd /build/sources || exit 1

echo "Checking for the .config file..."
if [ -f .config ]; then
    echo "The .config file exists."
else
    echo "The .config file does not exist."
    echo "Please ensure that it's present in the build directory."
    exit 1
fi

echo "Start kernel build..."

make mrproper -j"$(nproc)"
mkdir out
cp /build/.config .config
make -j"$(nproc)"

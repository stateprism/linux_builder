#!/usr/bin/env bash
# -*- coding: utf-8 -*-

function download_kernel() {
	echo "Kernel archive url: $kernel_url"
	echo "Downloading the kernel archive..."
	curl -SsL "$kernel_url" -o kernel.tar.xz
	echo "$kernel_url" >.kernel_url_cached
}

builder_ver="$(cat /scripts/scripts_ver)"

echo "Builder version: $builder_ver"

cd /build || exit 1

# if the sources or kernel_archive exists, remove them
[ -d sources ] && rm -rf sources

mkdir sources

# if no .kernel_url file exists, ask for the kernel archive url
if [ ! -f .kernel_url ]; then
	echo "Please input the kernel archive url:"
	read -r kernel_url
	echo "$kernel_url" >.kernel_url
else
	kernel_url=$(cat .kernel_url)
fi

if [ -f ".kernel_url_cached" ]; then
	# if the kernel url is the same as the cached one, skip downloading
	if [ "$(cat .kernel_url_cached)" = "$kernel_url" ]; then
		echo "The kernel archive url is the same as the cached one."
		echo "Skipping the download..."
	else
		download_kernel
	fi
else
	download_kernel
fi

echo "Extracting the kernel archive..."
tar -xf kernel.tar.xz -C /build/sources --strip-components=1

cd /build || exit 1

# if the first argument is menuconfig, run menuconfig
if [ "$1" = "menuconfig" ]; then
	cd /build/sources || exit 1
	echo "Running menuconfig..."
	make menuconfig
	echo "Copying the generated .config file to the build directory as .config-generated"
	cp /build/sources/.config /build/.config-generated
	exit 0
fi

cd /build || exit 1
cp .config sources/.config

#run build.sh
/scripts/build.sh

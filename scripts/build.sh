#!/bin/bash

tarball_url=http://www.imagemagick.org/download/ImageMagick.tar.gz
temp_dir=$(mktemp -d /tmp/compile.XXXXXXXXXX)

echo "Serving files from /tmp on $PORT"
cd /tmp
python -m SimpleHTTPServer $PORT &

cd $temp_dir
echo "Temp dir: $temp_dir"

echo "Downloading $tarball_url"
curl -L $tarball_url | tar xzv

(
	cd ImageMagick-*
	./configure --prefix=/tmp/imagemagick
	make install
)

while true
do
	sleep 1
	echo "."
done

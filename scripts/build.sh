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
	./configure --prefix=/tmp/imagemagick \
		 '--disable-silent-rules' 'CFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' 'CPPFLAGS=-D_FORTIFY_SOURCE=2' 'CXXFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' 'FFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4' 'GCJFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4' 'LDFLAGS=-Wl,-Bsymbolic-functions -Wl,-z,relro' '--with-modules' '--with-gs-font-dir=/usr/share/fonts/type1/gsfonts' '--with-magick-plus-plus' '--with-djvu' '--with-wmf' '--without-gvc' '--enable-shared' '--without-dps' '--without-fpx' '--x-includes=/usr/include/X11' '--x-libraries=/usr/lib/X11'
	
	make install
)

while true
do
	sleep 1
	echo "."
done

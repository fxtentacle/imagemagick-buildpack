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

echo '#!/bin/sh' > /tmp/gcc-with-flags.sh
echo "exec /app/.apt/usr/bin/gcc --sysroot=/app/.apt -I/app/.apt/include  -I/app/.apt/usr/include -I/app/.apt/usr/include/x86_64-linux-gnu -L/app/.apt/lib -L/app/.apt/usr/lib -L/app/.apt/usr/lib/x86_64-linux-gnu \"\$@\"" >> /tmp/gcc-with-flags.sh
chmod +x /tmp/gcc-with-flags.sh

(
	cd ImageMagick-*
    export LD_LIBRARY_PATH=/app/.apt/lib/x86_64-linux-gnu:/app/.apt/usr/lib:/app/.apt/usr/lib/x86_64-linux-gnu
    export CC=/tmp/gcc-with-flags.sh
	./configure --prefix=/tmp/imagemagick \
		 --with-gcc-arch=x86-64 \
		 '--disable-silent-rules' \
		'CFLAGS=--sysroot /app/.apt -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' \
		'CPPFLAGS=--sysroot /app/.apt -D_FORTIFY_SOURCE=2' 'CXXFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' \
		'FFLAGS=--sysroot /app/.apt -g -O2 -fstack-protector --param=ssp-buffer-size=4' \
		'GCJFLAGS=--sysroot /app/.apt -g -O2 -fstack-protector --param=ssp-buffer-size=4' \
		'LDFLAGS=--sysroot /app/.apt -Wl,-Bsymbolic-functions -Wl,-z,relro -L/app/.apt/usr/lib -L/app/.apt/usr/lib/x86_64-linux-gnu' \
		'--with-gs-font-dir=/usr/share/fonts/type1/gsfonts' \
		'--with-magick-plus-plus' '--with-djvu' '--with-wmf' '--without-gvc' '--enable-shared' '--without-dps' '--without-fpx' '--x-includes=/usr/include/X11' '--x-libraries=/usr/lib/X11'
	#  did test. it's faster without --disable-openmp
	
	make install
	
	zip -9r /tmp/imagemagick.zip /tmp/imagemagick
)

while true
do
	sleep 1
	echo "."
done

FROM docker.io/heroku/builder:22

RUN mkdir -p /tmp/cache
COPY Aptfile /app/Aptfile
RUN git clone https://github.com/fxtentacle/heroku-buildpack-apt.git /tmp/heroku-buildpack-apt
RUN chmod 0777 /app
RUN bash /tmp/heroku-buildpack-apt/bin/compile /app /tmp/cache

RUN curl -L https://download.imagemagick.org/archive/ImageMagick-6.9.13-25.tar.gz | tar xzv

RUN echo '#!/bin/sh' > /tmp/gcc-with-flags.sh
RUN echo "exec gcc-11 --sysroot=/app/.apt -I/app/.apt/include  -I/app/.apt/usr/include -I/app/.apt/usr/include/x86_64-linux-gnu -L/app/.apt/lib -L/app/.apt/usr/lib -L/app/.apt/usr/lib/x86_64-linux-gnu \"\$@\"" >> /tmp/gcc-with-flags.sh
RUN chmod +x /tmp/gcc-with-flags.sh

RUN echo '#!/bin/sh' > /tmp/gpp-with-flags.sh
RUN echo "exec g++-11 --sysroot=/app/.apt -I/app/.apt/include  -I/app/.apt/usr/include -I/app/.apt/usr/include/x86_64-linux-gnu -L/app/.apt/lib -L/app/.apt/usr/lib -L/app/.apt/usr/lib/x86_64-linux-gnu \"\$@\"" >> /tmp/gpp-with-flags.sh
RUN chmod +x /tmp/gpp-with-flags.sh

ENV CC=/tmp/gcc-with-flags.sh
ENV CXX=/tmp/gpp-with-flags.sh
ENV LD_LIBRARY_PATH=/app/.apt/lib/x86_64-linux-gnu:/app/.apt/usr/lib:/app/.apt/usr/lib/x86_64-linux-gnu
ENV PKG_CONFIG_PATH=/app/.apt/usr/lib/x86_64-linux-gnu/pkgconfig

RUN rm /app/.apt/usr/lib/x86_64-linux-gnu/libwmflite.a
RUN ln -s /usr/lib/x86_64-linux-gnu/libicuuc.so.70 /app/.apt/usr/lib/x86_64-linux-gnu/
RUN ln -s /usr/lib/x86_64-linux-gnu/libicudata.so.70 /app/.apt/usr/lib/x86_64-linux-gnu/


WORKDIR /layers/ImageMagick-6.9.13-25
RUN ./configure --prefix=/tmp/imagemagick --with-gcc-arch=x86-64   '--disable-silent-rules'  \
'CFLAGS=--sysroot /app/.apt -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -I/app/.apt/usr/include/libxml2   -I/app/.apt/usr/include/libpng12   -I/app/.apt/usr/include/freetype2 -fopenmp' \
'CPPFLAGS=--sysroot /app/.apt -D_FORTIFY_SOURCE=2'  'CXXFLAGS=--sysroot /app/.apt -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -fopenmp' \
'FFLAGS=--sysroot /app/.apt -g -O2 -fstack-protector --param=ssp-buffer-size=4'  \
'GCJFLAGS=--sysroot /app/.apt -g -O2 -fstack-protector --param=ssp-buffer-size=4 -fopenmp' \
'LDFLAGS=--sysroot /app/.apt -Wl,-Bsymbolic-functions -Wl,-z,relro -L/app/.apt/usr/lib -L/app/.apt/usr/lib/x86_64-linux-gnu -L/usr/lib/x86_64-linux-gnu/ '  \
'--with-gs-font-dir=/usr/share/fonts/type1/gsfonts' \
--with-magick-plus-plus --with-djvu --without-gvc --enable-shared --without-dps --without-fpx --with-png --with-webp --with-zlib --without-fftw --without-flif --without-heic --without-x --with-wmf
RUN make -j 32 || true
RUN make install

RUN mkdir -p /tmp/output &&\
    mv /tmp/imagemagick/bin/* /tmp/output &&\
    mv /tmp/imagemagick/lib/libMagick* /tmp/output &&\
    mv /tmp/imagemagick/etc/ImageMagick-6/delegates.xml /tmp/output

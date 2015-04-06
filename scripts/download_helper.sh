# before using this, set HEROKUAPPURL to something useful. e.g. HEROKUAPPURL="https://pure-savannah-1815.herokuapp.com/"

mkdir /tmp/imagemagick-dl
cd /tmp/imagemagick-dl
curl "$HEROKUAPPURL/imagemagick.zip" -o imagemagick.zip
unzip imagemagick.zip

mv  /tmp/imagemagick-dl/tmp/imagemagick/bin/* /app/bin
#mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/ImageMagick-6.9.1 /app/bin/ImageMagick-6.9.1
mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/libMagick* /app/bin




mv  /tmp/imagemagick-dl/tmp/imagemagick/bin/* /gitosis/imagemagick-buildpack/bin/cedar-14
mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/libMagick* /gitosis/imagemagick-buildpack/bin/cedar-14

cd -
rm -r /tmp/imagemagick-dl


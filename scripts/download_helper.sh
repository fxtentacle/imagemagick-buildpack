# before using this, set HEROKUAPPURL to something useful. e.g. HEROKUAPPURL="https://pure-savannah-1815.herokuapp.com/"

mkdir /tmp/imagemagick-dl
cd /tmp/imagemagick-dl
curl "$HEROKUAPPURL/imagemagick.zip" -o imagemagick.zip
unzip imagemagick.zip

mv  /tmp/imagemagick-dl/tmp/imagemagick/bin/* /app/bin
#mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/ImageMagick-6.9.1 /app/bin/ImageMagick-6.9.1
mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/libMagick* /app/bin



rm -r /gitosis/imagemagick-buildpack/bin/cedar-14/*
mv  /tmp/imagemagick-dl/tmp/imagemagick/bin/* /gitosis/imagemagick-buildpack/bin/cedar-14
mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/libMagick* /gitosis/imagemagick-buildpack/bin/cedar-14

rm bin/cedar-14/libMagick++-6.Q16.so
ln -s libMagick++-6.Q16.so.6.0.0 bin/cedar-14/libMagick++-6.Q16.so
rm bin/cedar-14/libMagick++-6.Q16.so.6
ln -s libMagick++-6.Q16.so.6.0.0 bin/cedar-14/libMagick++-6.Q16.so.6

rm bin/cedar-14/libMagickCore-6.Q16.so
ln -s libMagickCore-6.Q16.so.2.0.0 bin/cedar-14/libMagickCore-6.Q16.so
rm bin/cedar-14/libMagickCore-6.Q16.so.2
ln -s libMagickCore-6.Q16.so.2.0.0 bin/cedar-14/libMagickCore-6.Q16.so.2

rm bin/cedar-14/libMagickWand-6.Q16.so
ln -s libMagickWand-6.Q16.so.2.0.0 bin/cedar-14/libMagickWand-6.Q16.so
rm bin/cedar-14/libMagickWand-6.Q16.so.2
ln -s libMagickWand-6.Q16.so.2.0.0 bin/cedar-14/libMagickWand-6.Q16.so.2

cd -
rm -r /tmp/imagemagick-dl


# before using this, set HEROKUAPPURL to something useful. e.g. 
# export HEROKUAPPURL="https://pure-savannah-1815.herokuapp.com/"

mkdir /tmp/imagemagick-dl
cd /tmp/imagemagick-dl
curl "$HEROKUAPPURL/imagemagick.zip" -o imagemagick.zip
unzip imagemagick.zip
cd -

mv  /tmp/imagemagick-dl/tmp/imagemagick/bin/* /app/bin
#mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/ImageMagick-6.9.1 /app/bin/ImageMagick-6.9.1
mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/libMagick* /app/bin


mkdir -p /gitosis/imagemagick-buildpack/binaries-heroku-16
rm -r /gitosis/imagemagick-buildpack/binaries-heroku-16/*
mv  /tmp/imagemagick-dl/tmp/imagemagick/bin/* /gitosis/imagemagick-buildpack/binaries-heroku-16
mv  /tmp/imagemagick-dl/tmp/imagemagick/lib/libMagick* /gitosis/imagemagick-buildpack/binaries-heroku-16

rm binaries-heroku-16/libMagick++-6.Q16.so
ln -s libMagick++-6.Q16.so.8.0.0 binaries-heroku-16/libMagick++-6.Q16.so
rm binaries-heroku-16/libMagick++-6.Q16.so.8
ln -s libMagick++-6.Q16.so.8.0.0 binaries-heroku-16/libMagick++-6.Q16.so.8

rm binaries-heroku-16/libMagickCore-6.Q16.so
ln -s libMagickCore-6.Q16.so.6.0.0 binaries-heroku-16/libMagickCore-6.Q16.so
rm binaries-heroku-16/libMagickCore-6.Q16.so.6
ln -s libMagickCore-6.Q16.so.6.0.0 binaries-heroku-16/libMagickCore-6.Q16.so.6

rm binaries-heroku-16/libMagickWand-6.Q16.so
ln -s libMagickWand-6.Q16.so.6.0.0 binaries-heroku-16/libMagickWand-6.Q16.so
rm binaries-heroku-16/libMagickWand-6.Q16.so.6
ln -s libMagickWand-6.Q16.so.6.0.0 binaries-heroku-16/libMagickWand-6.Q16.so.6

rm -r /tmp/imagemagick-dl


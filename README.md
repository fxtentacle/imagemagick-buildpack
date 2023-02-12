Custom buildpack that will install a more recent ImageMagic into /app/bin on Heroku. 

Currently using ImageMagick-6.9.12-76 Q16. See build.sh for config flags.

Supports cedar-14, heroku-16, heroku-18.

# How to use

1. Add this buildpack to your app. 
2. Add the SOs to your search path: `heroku config:set LD_LIBRARY_PATH=/app/bin:/app/.apt/usr/lib/x86_64-linux-gnu`
3. Use /app/bin/convert and /app/bin/identify. BTW, the default cedar-14 PATH includes /app/bin, so this might happen automatically.

# How to upgrade ImageMagick

`heroku create`

`heroku config:set BUILDPACK_URL=https://github.com/maximkulkin/heroku-buildpack-dummy.git`

`git push heroku master`

Now you'll have a new Heroku app on the default stack (currently cedar-14) that runs the `scrupts/build.sh` script in this buildpack. That script will download the most recent ImageMagick source and configure it with default options.

Use `heroku logs -t` to see when compilation is done. It'll start showing dots..

`heroku open`

1. Download all files from /tmp/imagemagick or download imagemagick.zip
2. Chmod +x them
3. put them into `bin/$STACK/` into this buildpack. $STACK shall be the name of your stack as given in the Heroku $STACK variable.

`heroku ps:scale web=0` to turn off the dyno.

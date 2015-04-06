Custom buildpack that will install a more recent ImageMagic into /app/bin on Heroku. Supports cedar-14.

# How to use
Just add this buildpack to your app. Then use /app/bin/convert etc.

# How to upgrade ImageMagick

`heroku create`

`heroku config:set BUILDPACK_URL=https://github.com/maximkulkin/heroku-buildpack-dummy.git`

`git push heroku master`

Now you'll have a new Heroku app on the default stack (currently cedar-14) that runs the `scrupts/build.sh` script in this buildpack. That script will download the most recent ImageMagick source and configure it with default options.

Use `heroku logs -t` to see when compilation is done. It'll start showing dots..

`heroku open`

1. Download all files from /tmp/imagemagick
2. Chmod +x them
3. put them into `bin/$STACK/` into this buildpack. $STACK shall be the name of your stack as given in the Heroku $STACK variable.



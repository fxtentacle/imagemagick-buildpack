Custom buildpack that will install a more recent ImageMagic into /app/bin on Heroku. 

Currently using ImageMagick-6.9.13-25 Q16. See build.sh for config flags.

Supports cedar-14, heroku-16, heroku-18, heroku-20, heroku-22.


# How to use

1. Add this buildpack to your app. 
2. Add the SOs to your search path: `heroku config:set LD_LIBRARY_PATH=/app/bin:/app/.apt/usr/lib/x86_64-linux-gnu`
3. Use /app/bin/convert and /app/bin/identify. BTW, the default cedar-14 PATH includes /app/bin, so this might happen automatically.

# How to upgrade ImageMagick

See `build_me.sh.`

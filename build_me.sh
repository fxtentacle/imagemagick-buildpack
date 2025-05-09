docker build -t imagemagick-buildpack .
mkdir ./binaries-heroku-22
docker run -it --rm -v ./binaries-heroku-22:/output imagemagick-buildpack bash -c "cp -r /tmp/output/* /output"
git add binaries-heroku-22/

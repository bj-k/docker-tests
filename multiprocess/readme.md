# multiprocess
Testproject for a docker container with multiple processes (1st runs always, 2nd script exits).
If you pass the parameter 'failed' to 'docker run', the container cannot be created.

## Build base image
docker build -f Dockerfile_base -t bjk/debian:procps .

## Build script image
docker build -t bjk/multiprocess .

## Run container
docker run --rm -name mp bjk/multiprocess [succeed|]fail

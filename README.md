## skiznod/dxvk-docker-archlinux

automated docker image with all the build tools for dxvk based on archlinux

# Notes

- The build of the image might be slow as some of the -bin are
stored on sourceforge. It sometimes stops the build with
#ERROR: Failure while downloading https://sourceforge.net/xxxxx.tar.xz
Just run the build again

- The image runs the build and then exists

## Volume
- **/home/build/artifacts** -> dxvk binaries end up here


## Example Usage
```
docker run \
    --rm \
    -ti \
    -v /my-dxvk:/home/build/artifacts \
    --name dxvk-builder
    dxvk-docker-archlinux
```
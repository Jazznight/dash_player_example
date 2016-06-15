#!/bin/sh

. lib/utility.func


rm -rf media
mkdir media
cd media

DIR=`pwd`

LIST="720 576 480 360"
for res in `echo $LIST`
do
    case $res in
        "720")
            mkdir -p ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4

            ;;
        "576")
            mkdir -p ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4
            ;;
        "480")
            mkdir -p ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4
            ;;
        "360")
            mkdir -p ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4
            ;;
        *)
            echo ""
            echo "  ....Nothing to do for resolution [$res]"
            echo ""
            exit 100
            ;;
    esac

    echo $res
done

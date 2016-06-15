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
            mkdir $res
            transcode $1 /tmp/out_${res}.mp4 2400 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

            ;;
        "576")
            mkdir $res
            transcode $1 /tmp/out_${res}.mp4 1200 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

            ;;
        "480")
            mkdir $res
            transcode $1 /tmp/out_${res}.mp4 1000 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

            ;;
        "360")
            mkdir $res
            transcode $1 /tmp/out_${res}.mp4 800 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

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

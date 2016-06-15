#!/bin/sh

transcode()
{
    input=$1
    output=$2
    bitrate=$3
    resolution=$4

    ffmpeg \
       -y \
       -i $input \
       -hide_banner -nostats -movflags +faststart -c:v libx264 -r 24 -g 120 -keyint_min 120 -sc_threshold 0 \
       -b:v ${bitrate}k \
       -maxrate ${bitrate}k \
       -bufsize $((bitrate*2))k \
       -vf scale=-2:${resolution} \
       $output
}

hls()
{
    duration=$1
    index=$2
    url=$3
    file=$4
    input=$5

    mp42hls \
        --hls-version 4 \
        --segment-duration $duration \
        --index-filename $index \
        --segment-url-template $url \
        --segment-filename-template $file \
        $input
}

fragment()
{
    duration=$1
    input=$2
    output=$3

    mp4fragment \
        --fragment-duration 5000 \
        $input \
        $output
}

dash()
{
    index=$1
    shift
    file=$1
    shift
    input=$@

    mp4dash --force \
        --profiles=live \
        --mpd-name=$index \
        -o $file \
        $input
}
#mp42hls --hls-version 3 --segment-duration 5 --index-filename /tmp/media/360.m3u8 --segment-url-template media/360/hls-%d.ts --segment-filename-template /tmp/media/360/hls-%d.ts out_360.mp4

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
            #transcode $1 /tmp/out_${res}.mp4 2400 $res
            #transcode $1 /tmp/out_${res}.mp4 1900 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/dash
            ;;
        "576")
            mkdir $res
            #transcode $1 /tmp/out_${res}.mp4 1200 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/dash
            ;;
        "480")
            mkdir $res
            #transcode $1 /tmp/out_${res}.mp4 1000 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/dash
            ;;
        "360")
            mkdir $res
            #transcode $1 /tmp/out_${res}.mp4 800 $res
            fragment 5000 /tmp/out_${res}.mp4 /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/hls
            hls 5 ${res}/${res}.m3u8 hls/%04d.ts ${DIR}/${res}/hls/%04d.ts /tmp/out_${res}_fragmented.mp4

            mkdir ${res}/dash
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
dash dash.mpd ${DIR}/ /tmp/out_*_fragmented.mp4

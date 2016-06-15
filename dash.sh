#!/bin/sh

. lib/utility.func


mkdir -p media
cd media

DIR=`pwd`
dash_multiple_bitrate dash.mpd ${DIR}/ /tmp/out_*_fragmented.mp4

cp /tmp/out_720.mp4 ./

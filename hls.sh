#!/bin/sh

. lib/utility.func


mkdir -p media
cd media

DIR=`pwd`
hls_multiple_bitrate hls.m3u8 ${DIR} /tmp/out_*_fragmented.mp4

cp /tmp/out_720.mp4 ./

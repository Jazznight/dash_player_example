# README #

這是一個完整的bitdash範例，內含：
* 不用授權的bitdash palyer (但會有logo)
* dash格式影片 (.mpd + .m4u)
* hls格式的影片 (.m3u8 + .ts)


### 檔案說明 ###

* `sample/` => 影片檔
  * `ts/` => hls格式
  * `video/` => dash格式 - 影
  * `audio/` => dash格式 - 音
  
### 使用說明 ###

* `node server.js 1234` => 1234是可自訂的port

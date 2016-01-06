<?PHP

$ip = "168.168.168.168";
$sec_key = "vickyisonfire";
$expired_time = time() + 60;  // Expire in 60 sec
$static_path = 'static/video/XV-1199/XV-1199_dash.mpd';

$original_text = $expired_time . $static_path . $ip . ' ' . $sec_key;

$md5 = md5( $original_text, true );
$base = base64_encode( $md5 );

$search = array('+','/','=');
$replace = array('-','_','');
$base = base64_encode( $md5 );
$enc = str_replace( $search, $replace, $base );
echo $static_path . '?md5=' .$enc . '&expires=' . $expired_time
?>

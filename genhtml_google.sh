#!/bin/bash

echo -e "HTTP/1.1 200 OK\r\n\
$(date)\r\n\
Content-Type: text/html\r\n\
\r\n";

cat ./templates/header.html

OLDIFS=$IFS
IFS=";"

while read _id email secret counter type provider issuer original_name
 do


	url="otpauth://totp/"$email"?secret="$secret"&issuer="$issuer;
	echo '<div class="qrcode">'
	echo '<div class="title">'$email'</div>'
	echo '<div class="code" id="__qrcode__'$_id'"></div>'
	echo '<script>'
	echo '	new QRCode(document.getElementById("__qrcode__'$_id'"), "'$url'");'
	echo '</script>'
	echo '</div>'


 done < $1
 IFS=$OLDIFS


cat ./templates/footer.html

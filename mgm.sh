#!/bin/bash

APIURL=https://servis.mgm.gov.tr/api

function time_parse {
	sed -e 's/-[0-9]*T/& -/g' -e 's/T -/_/g' -e 's/\.[0-9][0-9][0-9]Z//g'
}
function get_info {
	if [ "$1" == "ililce" ];then
		LINK="$APIURL/merkezler?il=$2&ilce=$3"
	elif [ "$1" == "lokasyon" ];then
		LINK="$APIURL/merkezler/lokasyon?enlem=$2&boylam=$3"
	else
		exit 1
	fi
	curl -s "$LINK" |
	jq '.[] | {alternatifHadiseIstNo,boylam,enlem,gunlukTahminIstNo,il,ilce,merkezId,saatlikTahminIstNo,sondurumIstNo,yukseklik} | .[]' | dos2unix |
	sed -z 's/\n/ /g'
}
function get_sondurumlar {
	 curl -s "$APIURL/sondurumlar?merkezid=$1" | jq '.[]'  | time_parse |
	 jq '.' | dos2unix 
	 #sed -z 's/\n/ /g'
}
function get_gunluk {
	 curl -s "$APIURL/tahminler/gunluk?istno=$1" | jq '.[]' | time_parse |dos2unix
}
function get_saatlik {
	 curl -s "$APIURL/tahminler/saatlik?istno=$1" | jq '.[] | .[]' | sed 1,3d | jq '.[]' | time_parse | dos2unix
}

case "$1" in
	sondurumlar)
		MERKEZID=$(get_info ililce $2 $3 | awk '{print $7}')
		get_sondurumlar $MERKEZID
		;;
	gunluk)
		GUNID=$(get_info ililce $2 $3 | awk '{print $4}')
		get_gunluk $GUNID
		;;
	saatlik)
		SAATID=$(get_info ililce $2 $3 | awk '{print $8}')
		get_saatlik $SAATID
		;;
	*)
		exit 1
		;;
esac
#!/bin/bash

function veri_cek {
	curl -s $@
}
function kodlama_cevir {
	dos2unix | iconv -f cp1254 -t utf8
}
function ayristir {
	grep '^[0-9][0-9][0-9][0-9]' | 
	awk '{if($8!="-.-"){$7=""}else{print $8=""}$6="";print}' |
	sed -e 's/ (/(/g' \
		-e 's/[A-Z] /&**/g' \
		-e 's/ \*\*/_/g' \
		-e 's/_İlksel/ İlksel/g' \
		-e 's/REVIZE[0-9][0-9]/&**/g' \
		-e 's/\*\*.*//g'
}
function duzenle {
	column -t
}
function ana_komut {
	veri_cek $SITE | kodlama_cevir | ayristir
}
function buyukluk_sirala {
	awk '{print |"sort -rnk6"}'
}
function derinlik_sirala {
	awk '{print |"sort -rnk5"}'
}
function sifir_derinlik_sil {
	grep -v " 0.0 "
}
function kontrol_edilmis {
	grep "REVIZE[0-9][0-9]$"
}
function buyukluk_sec {
	awk -v M1=$1 -v M2=$2 '{if($6>M1&&$6<M2){print}}'
}
function derinlik_sec {
	awk -v D1=$1 -v D2=$2 '{if($5>D1&&$5<D2){print}}'
}
function saat_sec {
	awk -v S1=$1 -v S2=$2 '{if($2>S1&&$2<S2){print}}'
}
function koordinat_sec {
	 awk -v E1=$1 -v E2=$2 -v B1=$3 -v B2=$4 '{if($3>E1&&$3<E2&&$4>B1&&$4<B2){print}}'
}
function satir_basi {
	awk 'BEGIN{print "Tarih Saat Enlem Boylam Derinlik Büyüklük Yer Çözümtürü"}{print}'
}
function kaydet {
	if [ -z $1 ];then
		ana_komut | satir_basi | duzenle > "$(pwd)/koeri.txt"
	else
		ana_komut | $@ |satir_basi | duzenle > "$(pwd)/koeri.txt"
	fi
}
SITE="http://www.koeri.boun.edu.tr/scripts/lst0.asp"
if [ -z $1 ];then
	ana_komut | duzenle 
else
	ana_komut | duzenle | $@
fi

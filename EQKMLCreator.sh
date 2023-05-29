#!/bin/bash
function sirala { awk -v FIELD="$1" -v MAG1="$2" -v MAG2="$3" '{if($FIELD>=MAG1){if($FIELD<MAG2)print}}'; }
function countkml { expr $(grep -c '<Placemark><name>' $@ | cut -d: -f2 | sed -z -e 's/\n/ /g' -e 's/ / + /g' -e 's/ + $//g') ;}
function empty_line_replace {
	awk -v field=$1 -v character="$2" '{
		for(i=field+1;i<=NF;i++) {
			if($field+1!=""){$field=$field"_"$i}
		}
		gsub(/_/,character,$field)
		print
	}'
}
function magnitude_print { awk -v mag1="$1" -v mag2="$2" -v field=$3 '{ if($field>=mag1&&$field<=mag2){print} ;}' ;}
function depth_print { awk -v depth1="$1" -v depth2="$2" -v field=$3 '{if ($field>depth1&&$field<depth2){print}}' ;}
function coordinate_print 	{
	awk -v lat1="$1" -v lat2="$2" -v lon1="$3" -v lon2="$4" -v latitude=$5 -v longitude=$6 '{
		if($latitude>=lat1&&$latitude<=lat2){if($longitude>=lon1&&$longitude<=lon2){print}}
	}'
}
function location_print	{ grep -i $@ ;}
function date_print {
	awk -v date="$1" -v time="$2" -v date=$4 -v time=$5 '{if($date~date&&$time~time)print}'
}
function createkml {
	function begın {
		printf "<kml>\n\t<Document>\n\t\t<name></name>\n\t\t<visibility>0</visibility>\n\t\t<open>0</open>\n"
		printf '		<Style id="sh_target"><IconStyle><color>ff7f00ff</color><scale>1.4</scale><Icon><href>http://maps.google.com/mapfiles/kml/shapes/target.png</href></Icon></IconStyle></Style>
		<Style id="sn_target"><IconStyle><color>ff7f00ff</color><scale>1.2</scale><Icon><href>http://maps.google.com/mapfiles/kml/shapes/target.png</href></Icon></IconStyle></Style>
		<Style id="s_ylw-pushpin"><IconStyle><scale>0.3</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="s_ylw-pushpin_hl"><IconStyle><scale>0.390909</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sh_shaded_dot"><IconStyle><color>ff0000ff</color><scale>1.18182</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sh_shaded_dot0"><IconStyle><color>ff0295f0</color><scale>0.609091</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sh_shaded_dot1"><IconStyle><color>ff00ff00</color><scale>0.727273</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sh_shaded_dot2"><IconStyle><color>ff7f0000</color><scale>1.063640</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sh_shaded_dot3"><IconStyle><color>ffffaa00</color><scale>0.845455</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sn_shaded_dot"><IconStyle><color>ff7f0000</color><scale>0.9</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sn_shaded_dot0"><IconStyle><color>ff00ff00</color><scale>0.6</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sn_shaded_dot1"><IconStyle><color>ff0295f0</color><scale>0.5</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sn_shaded_dot2"><IconStyle><color>ff0000ff</color><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<Style id="sn_shaded_dot3"><IconStyle><color>ffffaa00</color><scale>0.7</scale><Icon><href>http://maps.google.com/mapfiles/kml/pal2/icon18.png</href></Icon></IconStyle><LabelStyle><color>00ffffff</color></LabelStyle></Style>
		<StyleMap id="msn_shaded_dot"><Pair><key>normal</key><styleUrl>#sn_shaded_dot</styleUrl></Pair><Pair><key>highlight</key><styleUrl>#sh_shaded_dot2</styleUrl></Pair></StyleMap>
		<StyleMap id="msn_shaded_dot0"><Pair><key>normal</key><styleUrl>#sn_shaded_dot0</styleUrl></Pair><Pair><key>highlight</key><styleUrl>#sh_shaded_dot1</styleUrl></Pair></StyleMap>
		<StyleMap id="msn_shaded_dot1"><Pair><key>normal</key><styleUrl>#sn_shaded_dot2</styleUrl></Pair><Pair><key>highlight</key><styleUrl>#sh_shaded_dot</styleUrl></Pair></StyleMap>
		<StyleMap id="msn_shaded_dot2"><Pair><key>normal</key><styleUrl>#sn_shaded_dot1</styleUrl></Pair><Pair><key>highlight</key><styleUrl>#sh_shaded_dot0</styleUrl></Pair></StyleMap>
		<StyleMap id="msn_shaded_dot3"><Pair><key>normal</key><styleUrl>#sn_shaded_dot3</styleUrl></Pair><Pair><key>highlight</key><styleUrl>#sh_shaded_dot3</styleUrl></Pair></StyleMap>
		<StyleMap id="msn_target"><Pair><key>normal</key><styleUrl>#sn_target</styleUrl></Pair><Pair><key>highlight</key><styleUrl>#sh_target</styleUrl></Pair></StyleMap>
		<StyleMap id="m_ylw-pushpin"><Pair><key>normal</key><styleUrl>#s_ylw-pushpin</styleUrl></Pair><Pair><key>highlight</key><styleUrl>#s_ylw-pushpin_hl</styleUrl></Pair></StyleMap>'
	}
	function begın_folder { printf "\n\t\t<Folder>\n\t\t\t<name>$1</name>" ;}
	function endfolder { printf "\n\t\t</Folder>" ;}
	function placemark { printf "\n\t\t\t<Placemark><name>$7 - $6</name><visibility>0</visibility><description><![CDATA[<table width='300'> <tr><td>Yer</td> <td>$7</td></tr><tr><td>Enlem</td><td>$3</td></tr> <tr><td>Boylam</td><td>$4</td></tr> <tr><td>Derinlik</td><td>$5</td></tr> <tr><td>M</td><td>$6</td></tr> <tr><td>Tarih-Saat</td><td>$1 $2</td></tr></table>]]></description><styleUrl>$STYLE</styleUrl><Point><coordinates>$4,$3,0</coordinates><drawOrder>1</drawOrder></Point></Placemark>" ;}
	function end { printf "\n\t</Document>\n</kml>" ; }
	function style_c {
		if   [[ $1 -ge 0 && $1 < 1 ]];then STYLE=#m_ylw-pushpin
		elif [[ $1 -ge 1 && $1 < 2 ]];then STYLE=#m_ylw-pushpin
		elif [[ $1 -ge 2 && $1 < 3 ]];then STYLE=#m_ylw-pushpin
		elif [[ $1 -ge 3 && $1 < 4 ]];then STYLE=#msn_shaded_dot2
		elif [[ $1 -ge 4 && $1 < 5 ]];then STYLE=#msn_shaded_dot0
		elif [[ $1 -ge 5 && $1 < 6 ]];then STYLE=#msn_shaded_dot3
		elif [[ $1 -ge 6 && $1 < 7 ]];then STYLE=#msn_shaded_dot
		elif [[ $1 -ge 7 && $1 < 8 ]];then STYLE=#msn_shaded_dot1
		else STYLE=#msn_shaded_dot1
		fi
	}
	function program {
		if [ "$1" = "file" ];then
			PFILE=$2
		else
			PFILE=$TMP/eqlist
			"$@" > $PFILE
		fi
		#Magnitude Arrays
		MFILES=($TMP/eqlist0 $TMP/eqlist1 $TMP/eqlist2 $TMP/eqlist3 $TMP/eqlist4 $TMP/eqlist5 $TMP/eqlist6 $TMP/eqlist7 $TMP/eqlist8 $TMP/eqlist9)
		#Magnitude Parse Sort 6. Field
		for ((m=0;m<${#MFILES[@]};m++));do cat $PFILE | sirala 6 $m $(($m+1)) > $TMP/eqlist$m ; done
		begın #Begin KML
		#Create Placemarks
		for ((m=0;m<${#MFILES[@]};m++));do
			PFILE=${MFILES[$m]}
			LINE=$(grep -c . $PFILE)
			[ $LINE = 0 ] && continue
			style_c $m
			begın_folder "$m Magnitudes"
			for ((l=1;l<=$LINE;l++));do
				placemark $(sed -n $l'p' $PFILE)
			done
			endfolder
		done
		end
	}
	$@
}
function koeri {
	function sondepremler {
		function parse_data {
			sed 's/\r//g' |
			awk '{
				if($1~"^[0-9][0-9][0-9][0-9]"){
					if($8>=0.0){$7=$8}
					$6="";$8=""
					print
				}
			}'  | empty_line_replace 7 "" |
			awk '{gsub(/Quick|REVISE.*$/,"",$7);print $1,$2,$3,$4,$5,$6,$7}' |
			column -t
		}
		function get_data { curl -s "http://www.koeri.boun.edu.tr/scripts/lasteq.asp" | parse_data ;}
		function location_print	{ get_data | grep -i $@ ;}
		if [ "$1" == "magnitude" ];then
			get_data | magnitude_print $2 $3 6
		elif [ "$1" == "depth" ];then
			get_data | depth_print $2 $3 5
		elif [ "$1" == "coordinate" ];then
			get_data | coordinate_print $2 $3 $4 $5 3 4
		else
			get_data
		fi
	}
	function month_print {
		function parse_data {
			iconv -f CP1254 -t UTF8 |
			sed 's/\r//g;1d' |
			empty_line_replace 7 "" |
			awk '{print $1,$2,$3,$4,$5,$6,$7}' |
			awk '{gsub(/.lksel$|REVIZE.*$/,"",$7);print}' |
			column -t
		}
		function get_data { curl -s "http://udim.koeri.boun.edu.tr/zeqmap/saveas.asp?xmlt/$1$2.xml" | parse_data ;}
		function year_print {
			outfile="$1_KOERI.txt"
			this_month=$(date +%m)
			this_year=$(date +%Y)
			[ $1 -gt $this_year ] && return
			[ -f "$outfile" ] && rm -rf "$outfile"
			for ((month=1;month<=12;month++));do
				if [ $month -lt 10 ];then
					if [ $1 -eq $this_year ];then
						if [ $month -gt $this_month ];then
							return
						fi
					fi
					get_data $1 0$month >> "$outfile"
				else
					get_data $1 $month >> "$outfile"
				fi
			done
			cat "$outfile" | column -t
			rm "$outfile"
		}	
		if [ "$1" == "sonay" ];then
			get_data SonAY
		elif [ "$1" == "sonhafta" ];then
			get_data sonHafta
		elif [ "$1" == "son24saat" ];then
			get_data son24saat
		elif [ "$1" == "yilsec" ];then
			year_print $2
		else
			get_data $@
		fi		
	}
	function zeqdb {
		function parse { echo $1 | cut -d- -f$2 ;}
		function base {
			INDAY=$(parse $1 1) ; INMONTH=$(parse $1 2) ; INYEAR=$(parse $1 3)
			OUTDAY=$(parse $2 1) ; OUTMONTH=$(parse $2 2) ; OUTYEAR=$(parse $2 3)
			curl -s "http://www.koeri.boun.edu.tr/sismo/zeqdb/submitRecSearchT.asp?bYear=$INYEAR&bMont=$INMONTH&bDay=$INDAY&eYear=$OUTYEAR&eMont=$OUTMONTH&eDay=$OUTDAY&EnMin=$5&EnMax=$6&BoyMin=$7&BoyMax=$8&MAGMin=$3&MAGMax=$4&DerMin=0&DerMax=500&Tip=Deprem&ofName=$1$2$3_$4$5$6_0.0_9.0_24_994.txt" |
			iconv -f CP1254 -t UTF8 > $TMP/eqlist
			tidy -q -wrap $TMP/eqlist 2>&1 |  
			awk  '
				{
					if($1~"^[0-9]"){
						gsub(/\.[0-9][0-9]/,"",$4) #Milisecond Remove
						if($7~"0000")
							gsub(/0*/,"0",$7)
						else
							gsub(/^0*/,"",$7) #Empty Zero Remove							
						if($3~"^2[0-9]*"){
							if($11>0.0){$8=$11}
						}#MW Magnitude replace
						$1="";$2="";$9="";$10="";$11="";$12="";$13="";if($14=="Ke"||$14=="Sm"){$14=""} # Other Magnitude Delete
						print
					}
				}' |
			sed 's/\[.*\]<br>//g;s/<br>//g;s/ (/(/g' |
			awk '{
				if($8!=""){$7=$7$8$9$10$11$12$13$14$15}
				print $1,$2,$3,$4,$5,$6,$7
			}'   |
			sort -k1 |
			column -t 
		}
		function lastyear {
			base 01-01-$(date +%Y) 31-12-$(date +%Y) $1 $2 28.00 50.00 18.00 50.00
		}
		function year {
			base 01-01-$1 31-12-$1 $2 $3 28.00 50.00 18.00 50.00
		}
		function select {
			base $1-$2-$3 $4-$5-$6 $7 $8 $9 ${10} ${11} ${12}
		}
		function select_year {
			base 01-01-$1 31-12-$2 $3 $4 28.00 50.00 18.00 50.00
		}
		function m4+ {
			base 01-01-1900 $(date +%d)-$(date +%m)-$(date +%Y) 4.0 9.0 28.00 50.00 18.00 50.00
		}
		function m5+ {
			base 01-01-1900 $(date +%d)-$(date +%m)-$(date +%Y) 5.0 9.0 28.00 50.00 18.00 50.00
		}
		function m6+ {
			base 01-01-1900 $(date +%d)-$(date +%m)-$(date +%Y) 6.0 9.0 28.00 50.00 18.00 50.00
		}
		function m7+ {
			base 01-01-1900 $(date +%d)-$(date +%m)-$(date +%Y) 7.0 9.0 28.00 50.00 18.00 50.00
		}
		function range {
			for((i=$1;i<=$2;i++));do
				printf "\n$i..."
				select_year $i $i $3 $4 > $i"_KOERI(ZEQDB).txt"
			done
		}
		if [ ! -z "$1" ];then
			$@
		else
			m5+
		fi
	}
	$@
}
function iris {
	function parse {
		awk '{
			if($1~"[0-9][0-9]-[A-Z]*"){
				$NF=""
				print
			}
		}' | empty_line_replace 7 "-" |
		awk '{print $1,$2,$3,$4,$6,$5,$7}' |
		column -t
	}
	function get_data { lynx -dump -width 1000 -nolist "https://ds.iris.edu/seismon/eventlist/index.phtml" ;}
	if [ -z "$1" ];then
		get_data | parse
	else
		$@
	fi
}
function afad {
	function sondepremler {
		son5deprem_url="https://deprem.afad.gov.tr/EventData/GetLast5Events"
		son24saat_url="https://deprem.afad.gov.tr/EventData/Get24HEvents"
		post_url="https://deprem.afad.gov.tr/EventData/GetEventsByFilter"
		function parse_main {
			empty_line_replace 1 "" |
			awk '{print $1}' |
			sed -z 's/\n/ /g;s/[0-9]*-[0-9]*-[0-9]*T/\n&/g' |
			awk '{gsub(/T|+00:00/," ",$1);print $1,$3,$2,$6,$4,$5}' |
			sort -k1 |
			column -t
		}
		function parse_post { jq -r '.eventList|.[]|.eventDate,.longitude,.latitude,.magnitude,.location,.depth' | parse_main ;}
		function parse_get { jq -r '.[]|.eventDate,.longitude,.latitude,.magnitude,.location,.depth'  | parse_main ;}
		function parse_count {  jq '.totalCount' ;}
		function getdata_post {
			curl -s -H 'Content-Type: application/json' \
			--data '{
				"EventSearchFilterList":[{
					"FilterType":9,"Value":"'$3'T'$4'.999Z"
				},
				{
					"FilterType":8,"Value":"'$1'T'$2'.000Z"
				}],
				"Skip":0,
				"Take":'$5',
				"SortDescriptor":{
					"field":"eventDate",
					"dir":"desc"
				}
			}' \
			-X POST "$post_url"
		}
		function getdata_get { curl -s "$1" | parse_get ;}
		if [ "$1" == "son5deprem" ];then
			getdata_get $son5deprem_url
		elif [ "$1" == "songun" ];then
			getdata_get $son24saat_url
		else
			count=$(getdata_post $1 $2 $3 $4 1 | parse_count)
			[ $count -eq 0 ] && return || getdata_post $1 $2 $3 $4 $count | parse_post
		fi
	}
	$@
}
function usgs {
	if [ -z "$1" ];then
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month_depth.kml" > "USGS_LASTMONTH.kml"
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week_depth.kml" > "USGS_LASTWEEK.kml"
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day_depth.kml" > "USGS_LASTDAY.kml"
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour_depth.kml" > "USGS_LASTHOUR.kml"
	else
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_$1_depth.kml" > "USGS_LAST$1.kml"
	fi
}
function kml_print {
	createkml program $@
}
function koerikml {
	if [ "$1" == "sonay" ];then
		kml_print koeri month_print $(date +%Y) $(date +%m) > KOERI_$(date +%Y)-$(date +%m).kml
	elif [ "$1" == "songun" ];then
		kml_print koeri month_print son24saat > KOERI_lastday.kml
	elif [ "$1" == "sondepremler" ];then
		kml_print koeri sondepremler > KOERI_sondepremler.kml
	else
		kml_print koeri $@
	fi
}
function iriskml {
	kml_print iris > iris.kml
}
function afadkml {
	if [ "$1" == "sonay" ];then
		kml_print afad sondepremler $(date +%Y)-$(date +%m)-01 00:00:00 $(date +%Y)-$(date +%m)-$(date +%d) 23:59:59 > AFAD_$(date +%Y)-$(date +%m).kml
	elif [ "$1" == "songun" ];then
		kml_print afad sondepremler $(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%Y)-$(date +%m)-$(date +%d) 23:59:59 > AFAD_$(date +%Y)-$(date +%m)-$(date +%d).kml
	else
		kml_print afad sondepremler $@
	fi
}
function usgskml {
	usgs $@
}
function emsckml {
	lynx -dump "http://www.emsc-csem.org/Earthquake/Map/earth/kml.php" > "$PWD/EMSC.kml"
}
function gfzkml {
	lynx -dump "http://geofon.gfz-potsdam.de/eqinfo/list.php?fmt=kml" > "$PWD/GFZ.kml"
}
function geonetkml {
	lynx -dump "https://wfs.geonet.org.nz/geonet/wms/kml?layers=geonet:quake_search_v1&maxFeatures=250" > "$PWD/GEONET.kml"
}
if [ -z "$1" ];then 
	echo USGS KML Writing...
	usgskml
	echo EMSC KML Writing...
	emsckml
	echo GFZ KML Writing...
	gfzkml
	echo GEONET KML Writing...
	geonetkml
	echo KOERI KML Writing...
	koerikml sonay
	echo AFAD KML Writing...
	afadkml sonay
	echo IRIS KML Writing...
	iriskml
else
	$@
fi

#!/bin/bash
function sirala { awk -v FIELD="$1" -v MAG1="$2" -v MAG2="$3" '{if($FIELD>=MAG1){if($FIELD<MAG2)print}}'; }
function countkml { expr $(grep -c '<Placemark><name>' $@ | cut -d: -f2 | sed -z -e 's/\n/ /g' -e 's/ / + /g' -e 's/ + $//g') ;}

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
	function begın_folder { printf "\n\t\t<Folder>\n\t\t\t<name>$1</name>" ; }
	function endfolder { printf "\n\t\t</Folder>" ; }
	function placemark {
		printf "\n\t\t\t<Placemark><name>$7 - $6</name><visibility>0</visibility><description><![CDATA[<table width='300'> <tr><td>Yer</td> <td>$7</td></tr><tr><td>Enlem</td><td>$3</td></tr> <tr><td>Boylam</td><td>$4</td></tr> <tr><td>Derinlik</td><td>$5</td></tr> <tr><td>M</td><td>$6</td></tr> <tr><td>Tarih-Saat</td><td>$1 $2</td></tr></table>]]></description><styleUrl>$STYLE</styleUrl><Point><coordinates>$4,$3,0</coordinates><drawOrder>1</drawOrder></Point></Placemark>"
	}
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
		#Delete Old Files
		for ((m=0;m<${#MFILES[@]};m++));do rm -f ${MFILES[$m]} ; done
		#Magnitude Parse Sort 6. Field
		for ((m=0;m<${#MFILES[@]};m++));do cat $PFILE | sirala 6 $m $(($m+1)) > $TMP/eqlist$m ; done
		begın #Begin KML
		#Create Placemarks
		for ((m=0;m<${#MFILES[@]};m++));do
			PFILE=${MFILES[$m]}
			LINE=$(grep -c . $PFILE)
			[ $LINE = 0 ] && continue
			begın_folder "$m Magnitudes"
			for ((l=1;l<=$LINE;l++));do
				MAG=$(sed -n $l'p' $PFILE | awk '{print $6}' | cut -d. -f1)
				style_c $MAG
				placemark $(sed -n $l'p' $PFILE)
			done
			endfolder
		done
		end
	}
	$@
}
function koeri {
	function get_data { curl -s "http://www.koeri.boun.edu.tr/scripts/lasteq.asp"  | grep '^[0-9]*\.' ;}	
	function parse_data { sed -e 's/   */</g' -e 's/ />/g' -e 's/</ /g' ;}
	function begin_print { awk 'BEGIN {print "Tarih Enlem Boylam Derinlik MD ML Mw Yer RevizeSayısı RevizeTarihi"}{print}' ;}
	function join_function { get_data|parse_data|begin_print ; }
	function end_parse { column -t | sed 's/>/-/g' ;}
	function revise_print { join_function | awk '{if(substr($9,0,6)=="REVISE"){print}}' | end_parse ; }
	function magnitude_print 	{
	join_function |
	awk -v type="$1" -v mag1="$2" -v mag2="$3" '{
		if(type=="mw"){
			if($7!="-.-"){
				if($7>=mag1&&$7<=mag2){print}
			}
		}
		if(type=="ml"){
			if($6>=mag1&&$6<=mag2){print}
		}
	}' |
	end_parse
}
	function depth_print		{ 
		join_function |
		awk -v depth1="$1" -v depth2="$2" '{
			if ($4>depth1&&$4<depth2){print}
		}' |
		end_parse
	}
	function coordinate_print 	{
		join_function |
		awk -v type="$1" -v lat1="$2" -v lat2="$3" -v lon1="$4" -v lon2="$5" '{
			if(type=="latitude"){
				if($2>=lat1&&$2<=lat2){print}
			}
			if(type=="longitude"){
				if($3>=lat1&&$3<=lat2){print}
			}
			if(type=="latlong"){
				if($2>=lat1&&$2<=lat2){if($3>=lon1&&$3<=lon2){print}}
			}
		}' |
		end_parse
	}
	function location_print	{ join_function | grep -i "$1" | end_parse ;}
	function month_print {
		curl -s "http://udim.koeri.boun.edu.tr/zeqmap/saveas.asp?xmlt/$1$2.xml" |
		iconv -f CP1254 -t UTF8 |
		sed -e 's/\t/ /g' -e 's/\r$//g' -e 's/  *$//g' -e 's/[0-9] /& /g' -e 's/   *(/ (/g' -e 's/   */</g' -e 's/ />/g' -e 's/</ /g' -e 1d |
		awk 'BEGIN{print "Tarih Saat Enlem Boylam Derinlik Büyüklük Yer"}{if($8!=""){$7=$7"_"$8"-"$9;$8="";$9=""}print}' | end_parse
	}
	function lastmonth { month_print SonAY ; }
	function lastweek { month_print sonHafta ; }
	function lastday { month_print son24saat ; }
	function seisco {
		POSTDATA="desc=descending&fromTD=$2&fromTM=$3&fromTY=$1&get_events=true&max_lat=&max_long=&max_mag=$8&min_depth=&min_lat=&min_long=&min_mag=$7&sort=Origin%20Time%20UTC&toD=$5&toM=$6&toY=$4"
		lynx -width 1000 -nolist -dump "http://sc3.koeri.boun.edu.tr/eqevents/eq_events?$POSTDATA" |
		grep '^ *[0-9]*\/' |
		sed -e 's/^ *//g' -e 's/° N/ N /g' -e 's/° S/ S /g' -e 's/° W/ W /g' -e 's/° E/ E /g' -e 's/[0-9] /& /g'  -e 's/ [0-9]/ &/g' -e 's/   */</g' -e 's/ /-/g' -e 's/</ /g' |
		awk 'BEGIN{print "Tarih Saat Enlem Boylam Derinlik M Yer"}{if($6=="S"){$5="-"$5};if($8=="W"){$7="-"$7}$6="";$8="";print $1,$2,$5,$6,$7,$9,$3,$10}' |
		column -t | sed 's/-[A-M]$//g'
	}
	function zeqdb {
		function parse { echo $1 | cut -d- -f$2 ;}
		function base {
			INDAY=$(parse $1 1) ; INMONTH=$(parse $1 2) ; INYEAR=$(parse $1 3)
			OUTDAY=$(parse $2 1) ; OUTMONTH=$(parse $2 2) ; OUTYEAR=$(parse $2 3)
			curl -s "http://www.koeri.boun.edu.tr/sismo/zeqdb/submitRecSearchT.asp?bYear=$INYEAR&bMont=$INMONTH&bDay=$INDAY&eYear=$OUTYEAR&eMont=$OUTMONTH&eDay=$OUTDAY&EnMin=$5&EnMax=$6&BoyMin=$7&BoyMax=$8&MAGMin=$3&MAGMax=$4&DerMin=0&DerMax=500&Tip=Deprem&ofName=$1$2$3_$4$5$6_0.0_9.0_24_994.txt" |
			iconv -f CP1254 -t UTF8 |
			sed -e 's/<br>/\n/g' -e 's/<hr>//g' -e 's/<b>//g' |
			grep '^[0-9][0-9][0-9]*' |
			awk '{$1="";$2="";$14="";print}' |
			sed -e 's/[0-9]*\.[0-9]*\.[0-9]*/& /g' -e 's/[0-9]*:[0-9]*:[0-9]*\.[0-9]*/& /g' -e 's/[0-9][0-9]\.[0-9][0-9][0-9][0-9]/& /g' -e 's/ [0-9]\.[0-9] / & /g' -e 's/^  //g' -e 's/\[.*\]//g'  -e 's/   */</g' -e 's/ />/g' -e 's/</ /g' -e 's/>$//g' |
			tac |
			awk '{print $1,$2,$3,$4,$5,$6,$12}' |
			column -t  |
			sed -e 's/>/-/g' -e 's/- (/-(/g'  -e 's/[()]//g' -e 's/--/-/g'
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
		function m5+ {
			base 01-01-1900 $(date +%d)-$(date +%m)-$(date +%Y) 5.0 9.0 28.00 50.00 18.00 50.00
		}
		function m6+ {
			base 01-01-1900 $(date +%d)-$(date +%m)-$(date +%Y) 6.0 9.0 28.00 50.00 18.00 50.00
		}
		function m7+ {
			base 01-01-1900 $(date +%d)-$(date +%m)-$(date +%Y) 7.0 9.0 28.00 50.00 18.00 50.00
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
		lynx -dump -width 1000 -nolist "https://ds.iris.edu/seismon/eventlist/index.phtml" |
		sed 's/^ *//g' | grep '^[0-9][0-9]\-' |
		sed -e 's/[0-9]*$//g' -e 's/[A-Z] /& /g' -e 's/  /-/g' -e 's/, /,/g' -e 's/---*//g' -e 's/\.-//g' |
		awk '{print $1,$2,$3,$4,$6,$5,$7}'
	}
	function cview {
		parse | awk 'BEGIN{print "Date Hour(UTC)" Latitude Longitude Depth Mag Location"}{print}' | column -t
	}
	if [ -z "$1" ];then
		cview
	else
		$@
	fi
}
function afad {
	function getdata {
		curl -s -X POST -F "exportType=$3" -F "searchedLastDayInput=$1" -F "searchedMInput=$2" -F "searchedUtcInput=0" "https://deprem.afad.gov.tr/latestCatalogsExport" |
		dos2unix |
		iconv -f CP1254 -t UTF8
	}
	function parse {
		getdata $1 $2 $3 |
		sed -e 's/^.*DDA,//g' \
			-e 's/,/ /g' \
			-e 's/:[0-9][0-9]Z/&  /g' \
			-e 's/Z   / /g' \
			-e 's/[0-9]\.[0-9][0-9][0-9][0-9][0-9] M.//g' \
			-e 's/  */ /g' \
			-e 's/-//g' \
			-e 's/  */ /g' \
			-e 's/[a-z] /&-/g' \
			-e 's/ -/-/g' \
			-e 's/ km\. /km.,/g' \
			-e 's/ km\./km.,/g' \
			-e 's/[()]//g' \
			-e 's/-$//g' \
			-e 's/[a-z] /&-/g' \
			-e 's/ -/-/g' \
			-e 's/^[0-9][0-9][0-9][0-9]/&-/g' \
			-e 's/^[0-9]*-[0-9][0-9]/&-/g'
	}
	function gettext { parse $1 $2 2 | sed 1d |awk 'BEGIN{print "Date Hour Latitude Longitude Depth Mag Location"}{print}' | column -t ;}
	function getkml	{ parse $1 $2 3 ;}
	if [ -z "$1" ];then
		gettext 1 0
	else
		$@
	fi
}
function usgs {
	OUTFOLDER="$PWD/USGS"
	if [ ! -d "$OUTFOLDER" ];then
		mkdir -p "$OUTFOLDER"
	fi
	if [ -z "$1" ];then
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month_depth.kml" > "$OUTFOLDER/USGS_LASTMONTH.kml"
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week_depth.kml" > "$OUTFOLDER/USGS_LASTWEEK.kml"
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day_depth.kml" > "$OUTFOLDER/USGS_LASTDAY.kml"
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour_depth.kml" > "$OUTFOLDER/USGS_LASTHOUR.kml"
	else
		curl -s "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_$1_depth.kml" > "$OUTFOLDER/USGS_LAST$1.kml"
	fi
}


function koerikml { createkml program koeri month_print $1 $2 > $1-$2.kml ;}
function koerilastdaykml { createkml program koerilastday > KOERI_lastday.kml ;}
function koerilastweekkml { createkml program koerilastweek > KOERI_lastweek.kml ;}
function koerilastmonthkml { createkml program koeri month_print $(date +%Y) $(date +%m) > $(date +%Y)-$(date +%m).kml ;}
function zeqdbkml { createkml program koeri zeqdb $@ > zeqdb.kml ;}
function iriskml { createkml program iris parse > iris.kml ;}
function afadkml { createkml program afad gettext $1 $2 > afad.kml ;}
function usgskml { usgs $@ ;}
function emsckml { wget -q -O "$PWD/EMSC_LAST2WEEK.kml" "http://www.emsc-csem.org/Earthquake/Map/earth/kml.php" ;}
function gfzkml { curl -s "http://geofon.gfz-potsdam.de/eqinfo/list.php?fmt=kml" > "$PWD/GFZ.kml" ;}
function geonetkml { curl -s "https://wfs.geonet.org.nz/geonet/wms/kml?layers=geonet:quake_search_v1&maxFeatures=250" > "$PWD/GEONET.kml" ;}
function bgskml { curl -s "http://quakes.bgs.ac.uk/earthquakes/recent_uk_events.kml" > "$PWD/BGS.kml" ;}
if [ -z "$1" ];then 
	echo USGS KML Writing...
	usgskml
	echo EMSC KML Writing...
	emsckml
	echo GFZ KML Writing...
	gfzkml
	echo GEONET KML Writing...
	geonetkml
	echo BGS KML Writing...
	bgskml
	echo KOERI KML Writing...
	koerilastmonthkml
	echo AFAD KML Writing...
	afadkml 7 0
	echo IRIS KML Writing...
	iriskml
else
	$@
fi

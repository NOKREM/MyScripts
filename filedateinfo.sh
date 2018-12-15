#/bin/bash
	stat $@ | grep -e "^  File:" -e "^Access: [0-9]" -e '^Modify: ' -e '^Change: ' -e '^ Birth: ' | tac |
	sed -z -e  's/\nChange: / Change: /g' -e 's/\nModify: / Modify: /g' -e 's/\nAccess: / Access: /g' -e 's/\n  File: / File: /g' |
	sed -e 's/^ //g' \
		-e 's/^Birth: //g' \
		-e 's/ Change: / /g' \
		-e 's/ Modify: / /g' \
		-e 's/ Access: / /g' \
		-e 's/ File: / /g' \
		-e 's/\.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] / /g' |
		awk 'BEGIN{print "OluşturmaTarihi DeğiştirmeTarihi DüzenmlemeTarihi ErişimTarihi GMT Dosyaİsmi"}{$3="";$6="";$9="";$1=$1"T"$2;$3="";$2="";$4=$4"T"$5;$5="";$7=$7"T"$8;$8="";$10=$10"T"$11;$11="";print}' |
	sort -n |
	column -t
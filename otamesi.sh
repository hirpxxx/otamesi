#!/bin/sh

function FC2(){
value=$1
echo "====Chk FC2===="
echo "引数:$value"
if [[ "$value" == *"FC2"* ]]
then
	ret_fc2=$( echo "$value" | sed -r "s/.*-([0-9]{6,7}).*/FC2-PPV-\1/" )
	ret_fc2=$( echo "$ret_fc2" | sed -r "s/PPV\-0/PPV\-/" )
	echo "$ret_fc2"
else
	ret_fc2="NG"
	echo "$ret_fc2" 
fi
}
#========================================================="
function NUMMOJINUM(){
value=$1
echo "====Chk NUMMOJINUM===="
echo "引数:$value"
#if [[ echo "$value" | grep -E "[0-9]\{2,4\}[A-Za-z]\{2,4\}.*[0-9]\{3,4\}" ]];
#then
	ret_numojinum=$( echo "$value" | sed -r "s/([0-9]\{2,4\}[A-Za-z]\{2,4\}).*([0-9]\{3,4\})/\1-\2/" )
	echo "$ret_numojinum"
#else
	ret_numojinum="NG"

#fi

}


echo "================================================================================"
inifile="otamesi.ini"
#ini=$( cat $inifaile )

#ls /Users/asaihiroyuki/Downloads
#ls /Users/asaihiroyuki/Downloads/ | grep -i "MP4\|MOV" | grep -v "【ＡＶ】\|【裏】\|Javmix"
#トレントファイル削除
rm /Users/asaihiroyuki/Downloads/*.torrent
#TargetPATH="/Users/asaihiroyuki/Downloads/"
#FILE_ARRAY=$(ls $TargetPATH | sort )
#echo $FILEARRAY[@]
#find $TargetPATH -name \*.mp4
echo "＝＝＝OUTファイル削除＝＝＝"
FILE_ARRAY+="UUUU"
out_file="filelist"
rm $out_file  > /dev/null 2>&1

TargetPATH="/Users/asaihiroyuki/Downloads"	
#TargetPATH="/Volumes/WD5000LPX"

find ~/Downloads -name \*.mp4 -o -name \*.mov -o -name \*.mkv | grep -v "【ＡＶ】\|【裏】" | sed -n "/\/Downloads\/.*\/.*\.[A-Za-z]\{2,3\}/P" | sort > $out_file

while read line
do
	echo "COPY:$line"
	mv "$line" "$TargetPATH/" 
	d_name=$(dirname "$line")
	echo "削除パス:$d_name"
	findarray=($(find "$d_name" ))
	echo "${findarray[@]}" 

done < ./$out_file


	
while read line
do 
	echo "======対象:$TargetPATH===================" 
	echo "====ファイル名の空白をアンスコに変換===="
	find "$line" -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov | grep -v "/._" | while read file
	do 
		echo "$file" | grep "\ "
		if [ $? -eq 0 ] ; then
			echo "空白：$file"
			file2=$(echo $file | sed -e "s/\ /_/g")
			echo "空白：$file2"
			mv "$file" "$file2"
		fi
	done
done < ./$inifile

echo "====対象ファイル取得===="
work_file="working"
rm $work_file > /dev/null 2>&1
rm $out_file > /dev/null 2>&1
while read line
do 
	TargetPATH=$line
	echo $TargetPATH
	find $TargetPATH -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov -o -name \*.mkv -o -name \*.MP4 | grep -v "【ＡＶ】\|【裏】\|SpankBang\|Watch\|写真ライブラリ" | grep -v "/._" | sort >> $out_file
	array=$( /usr/bin/find $TargetPATH -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov | grep -v "【ＡＶ】\|【裏】\|SpankBang\|Watch\|写真ライブラリ" | grep -v "/._" | sort )
	if [ $0 =  0 ];then
		echo $array[@] >> $out_file
	fi
	#echo "${warking_array[@]}" 
	#exit 0
done < ./$inifile
#exit 0
array=$( cat "$out_file" ) 

IFS_ORIGINAL="$IFS"
IFS="/"

while read line
do
	echo "LINE:$line"
	IFS="/"
	array=(${line})
	declare -i num=${#array[@]}-1
	#echo "分割:${#array[@]}:${array[$num]} $line"
	filenm=${array[$num]}
	motofile=${array[$num]}
	filenm=$(echo "$filenm" | sed -e "s/\.mp4//" )	
	filenm=$(echo "$filenm" | sed -e "s/\.mov//" )	
	filenm=$(echo "$filenm" | sed -e "s/\.mkv//" )	
	filenm=$(echo "$filenm" | sed -e "s/-uncensored//" )	
	filenm=$(echo "$filenm" | sed -e "s/-nyap2p\.com//" )	
	filenm=$(echo "$filenm" | sed -e "s/Javmix\.TV//" )	
	filenm=$(echo "$filenm" | sed -e "s/hhd[0-9]\{3\}.*\@//" )	
	filenm=$(echo "$filenm" | sed -e "s/hdd[0-9]\{3\}.*\@//" )	
	filenm=$(echo "$filenm" | sed -e "s/_UNCENSORED_LEAKED_NOWATERMARK//" )
	filenm=$(echo "$filenm" | sed -e "s/_UNCENSORED_LEAKED//" )
	filenm=$(echo "$filenm" | sed -e "s/_[0-9]$//" )	
	filenm=$(echo "$filenm" | sed -e "s/_[A-Za-z]$//" )	
	filenm=$(echo "$filenm" | sed -e "s/[^0-9A-Za-z]\|^(-)//g" )	
	#${#filenm}
	echo "${#filenm}:$filenm"
	rm "kekka"
	#if [ "${#filenm}" -lt 16 ] ; then
		FC2 "$filenm"
		#ret=$(FC2 "$filenm")
		echo "RET:$ret_fc2"
		if [[ $ret_fc2 = "NG" ]];
		then
			echo "$line\t$filenm" >> $work_file
		else
			echo "$line\t$ret_fc2" >> $work_file
			filenm="$ret_fc2"			
		fi 
		#NUMMOJINUM "$filenm"	
		#echo "RET:$ret_nummojinum"
                #if [$nummojinum != "NG" ];
                #then
                #         echo "$line\t$ret_nummojinum" >> $work_file
                #fi
		echo "=======検索:$filenm==========="
		#doc=$(curl --insecure 'https://javfree.me/?s="$filenm"')
		#https://sukebei.nyaa.si/?f=2&c=2_2&q=SDNM&s=id&o=asc
		echo "===========小文字→大文字=============" 	
		filenm=$(echo "$filenm" | tr a-z A-Z )
		echo "$filenm"	
		doc=$(curl --insecure "https://sukebei.nyaa.si/?f=2&c=2_2&q=$filenm&s=id&o=asc")
		echo $doc >> "test"
		doc=$(echo $doc | sed -r "s/\t//g")
		
		if [[ $doc == *"No results found"* ]];then
			#doc=$(curl --insecure 'https://javfree.me/?s="SDNM-300"')
			doc=$(echo $doc | grep "No results found")
			doc=$(echo $doc | sed -r "s/^.*(No\ results\ found).*$/\1/")
		else
			#doc=$(echo $doc | grep "entry-title" | grep "h2 class")
			#doc=$(echo $doc | sed -r "s/^.*<a.*>(.*)<.a.*$/\1/")
			#doc=$(echo $doc | sed -r "s/\[HD\]//")
			#doc=$(echo $doc | sed -r "s/\[.*\]//g")
			#doc=$(echo $doc | sed -r "s/^\ //")
			#doc=$(echo $doc | sed -r "s/\ /_/g")
			doc=$(echo $doc | grep "<a href" | grep "view" | grep "title" | grep -v "<th" | grep -v "中文字幕" )
			#echo "1==============================="
			#echo $doc
			#echo "1==============================="
			doc=$(echo $doc | grep -E '[ぁ-んァ-ン]' )
			doc=$(echo $doc | grep "<a href" | grep "view" | grep "title" | grep -v "<th" | grep -v "中文" |  head -n 1)
			#echo "2==============================="
			#echo $doc
			#echo "2==============================="
			doc=$(echo $doc | sed -r "s/^.*<a.*title=\"(.*)\">.*<\ a>.*$/\1/")
			#"💖
			doc=$(echo $doc | tr [a-z] [A-Z])
			doc=$(echo $doc | sed -r "s/^\ \{1,3\}//")
			doc=$(echo $doc | sed -r "s/💖//g")
			doc=$(echo $doc | sed -r "s/UNCENSORED_LEAKED_NOWATERMARK//g")
			#_UNCENSORED_LEAKED_NOWATERMARK
			doc=$(echo $doc | sed -r "s/\[.*\]//g")
			doc=$(echo $doc | sed -r "s/　//g")
			doc=$(echo $doc | sed -r "s/\ \{2,9\}/_/g")
			doc=$(echo $doc | sed -r "s/\ /_/g")
			doc=$(echo $doc | sed -r "s/\+\+\+_//")
			doc=$(echo $doc | sed -r "s/^\_//g")
			doc=$(echo $doc | sed -r "s/\+\+\+_//")
			doc=$(echo $doc | sed -r "s/\#\#\#//")
			echo "結果:$doc"	
			doc=$(echo $doc | sed -r "s/($filenm)/\1_/")
			doc=$(echo $doc | sed -r "s/__/_/g")
		fi
		
		echo "結果:$doc"	
		if [[ $doc == *"FC2"* ]] || [[ $doc == *"CARIB"* ]];
		then
                        ret=$( echo "$doc" | sed -r "s/FC2-PPV-([0-9]{6}).*/\1/" )
                        echo "文字数:$ret:"
                        ret=$( echo "$ret" | sed -r "s/ //g" )
                        ret=$( echo "$ret" | wc -m )
                        
			echo "文字数:$ret" 
                        if [[ 6 -eq "$ret" ]];
                        then
			        doc=$( echo "$doc" | sed -r "s/PPV-/PPV-0/" )
                        fi
			doc=$( echo "【裏】$doc")
		else
			if [[ $doc == *"No results found"* ]];
			then
				doc=$( echo "$doc" | sed -r "s/\ /_/g" )
			else
				doc=$( echo "【ＡＶ】$doc")
			fi
		fi
		IFS="$IFS_ORIGINAL"
		if [[ $doc != *"No_results_found"* ]];
		then
			#echo "$doc"	
			doc=$(echo $doc | sed -e "s/$/_/")	
			echo "MOTO:$doc$motofile"
			echo "$filenm:$doc" >> "kekka"
			TargetPATH=$(dirname $line)
			echo "$TargetPATH"
			echo "mv:$line $TargetPATH/$doc$motofile"
			mv "$line" "$TargetPATH/$doc$motofile"
		fi
		#exit 0 
	#fi
#done < ./$out_file
done << END 
$array
END

IFS="$IFS_ORIGINAL"

exit 0


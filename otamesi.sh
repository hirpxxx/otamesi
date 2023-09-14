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
work="otamesi.ini"
inifile="wortini.txt"
cat $work | sed "/^#/d" > $inifile 
echo "=====ini======"
echo $inifile

#inifile="otamesi.ini"

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

echo "=======ファイル移動(サブフォルダーから$TargetPATH へ)==========="
find ~/Downloads -name \*.mp4 -o -name \*.mov -o -name \*.mkv | grep -v "【ＡＶ】\|【裏】" | sed -n "/\/Downloads\/.*\/.*\.[A-Za-z]\{2,3\}/P" | sort > $out_file
while read line
do
	

	echo "MOVE FILE:$line"
	if [[ $doc != *"Tutorial_JP"* ]];then
		mv "$line" "$TargetPATH/" 
	else
		rm "$line" 
	fi
	d_name=$(dirname "$line")
	findarray=($(find "$d_name" ))
	echo "削除確認：$rm_dir"
	rm_dir=$(find $d_name -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov -o -name \*.mkv -o -name \*.MP4 -o -name \*.part)
	if [[ ${#rm_dir} -lt 1 ]]
	then
		echo "削除実行:$d_name"
		rm -rf $d_name
	fi

done < ./$out_file

#exit 0


while read line
do 
	echo "======対象:$TargetPATH===================" 
	echo "====ファイル名の空白をアンスコに変換===="
	find "$line" -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov | grep -v "C0930" | grep -v "/._" | while read file
	do 
		echo "$file" | grep "\ "
		if [[ $? -eq 0 ]] ; then
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
	find $TargetPATH -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov -o -name \*.mkv -o -name \*.MP4 | grep -v "【ＡＶ】\|【裏】\|SpankBang\|Watch\|写真ライブラリ\|xHamster\|Pornhub\|Javmix" | grep -v "/._" | sort >> $out_file
	array=$( /usr/bin/find $TargetPATH -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov | grep -v "【ＡＶ】\|【裏】\|SpankBang\|Watch\|写真ライブラリ\|xHamster\|Pornhub\|Javmix" | grep -v "/._" | sort )
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
	#ls | sort | grep オンライン視聴 | sed -e s/"\] .*"// | sed -e s/"\["// | sed -e s/"\[.*\]"// | sed -e s/\ //
	filenm=$(echo "$filenm" | sed -e s/"\]_.*"// | sed -e s/"\["// | sed -e s/"\[.*\]"// | sed -e s/\ //g )
	echo "変換前:$filenm:$motofile"
	filenm=$(echo "$filenm" | sed -e "s/\.mp4//" )	
	filenm=$(echo "$filenm" | sed -e "s/\.mov//" )	
	filenm=$(echo "$filenm" | sed -e "s/\.mkv//" )	
	filenm=$(echo "$filenm" | sed -e "s/-uncensored//" )	
	filenm=$(echo "$filenm" | sed -e "s/-nyap2p\.com//" )	
	filenm=$(echo "$filenm" | sed -e "s/Javmix\.TV//" )	
	filenm=$(echo "$filenm" | sed -e "s/hhd[0-9]\{3\}.*\@//" )	
	filenm=$(echo "$filenm" | sed -e "s/hdd[0-9]\{3\}.*\@//" )	
	filenm=$(echo "$filenm" | sed -e "s/^gg5.*\@//" )	
	filenm=$(echo "$filenm" | sed -e "s/\-C_GG5//" )	
	filenm=$(echo "$filenm" | sed -e "s/_UNCENSORED_LEAKED_NOWATERMARK//" )
	filenm=$(echo "$filenm" | sed -e "s/_UNCENSORED_LEAKED//" )
	filenm=$(echo "$filenm" | sed -e "s/_[0-9]$//" )	
	filenm=$(echo "$filenm" | sed -e "s/_[A-Za-z]$//" )	
	filenm=$(echo "$filenm" | sed -e "s/[^0-9A-Za-z]\|^(-)//g" )	
	if [[ $filenm == *"C0930"*  ]] ;then
		echo "C0930:$filenm"
		filenm=$(echo "$filenm" | sed -e "s/C0930\ /C0930+/" )	
	fi
	#gg5.co@
	echo "${#filenm}:$filenm"
	rm "kekka"
	if [[ "${#filenm}" -lt 16 ]] || [[ $filenm == *"CARIB"* ]] ; then
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
		#HEYZO処理
		if [[ $filenm == *"HEYZO"* ]];
		then
			filenm=$( echo "$filenm" | sed -e s/HEYZO-/HEYZO\+/ ) 
		fi


		echo "=======検索:$filenm==========="
		#doc=$(curl --insecure 'https://javfree.me/?s="$filenm"')
		#https://sukebei.nyaa.si/?f=2&c=2_2&q=SDNM&s=id&o=asc
		echo "===========小文字→大文字=============" 	
		filenm=$(echo "$filenm" | tr a-z A-Z )
		echo "$filenm"	
		if [[ ${#filenm} -lt 20 ]] || [[ $filenm == *"CARIB"* ]] ;then
			doc=$(curl --insecure "https://sukebei.nyaa.si/?f=2&c=2_2&q=$filenm&s=id&o=asc")
			sub_kensaku_kb=1
		else
			doc="<A>No results found</A>"
			sub_kensaku_kb=0
		fi
		doc=$(echo $doc | sed -r "s/\t//g")
		#echo "検索１結果$doc"
		if [[ $sub_kensaku_kb -eq 1 ]] && [[  $doc == *"No results found"* ]];then
			doc=$(curl --insecure "https://db.msin.jp/jp.search/movie?str=$filenm")
			#a href="/jp.page/movie?id=188370" title="AV史上もっとも綺麗な40代 宮本紗央里 42歳 AV Debut">
			doc=$(echo $doc | sed -r "s/^.*<a href.*title\=\"(.*)\">.*<\ a><\ div><div\ class.*<\ body>/\1/" )
			doc=$(echo "$filenm $doc" )
			#<a href=" view 3893611" title="< a>
			#<a href=" view 3893611" title=" ">
			#doc=$(echo "<a href=" view 3893611" title=""" $doc """> < a>")
			#検索結果がありません
			if [[ $doc == *"検索結果がありません"* ]];then
				doc="<A>No results found</A>"
			fi
			echo "===*** m s i n ***==="
			echo $doc
			echo "===*** m s i n ***==="
			sub_kensaku_kb=3
		fi
		#echo "検索２結果$doc"


		echo $doc >> "test"
		#exit 0
		#echo "最初 $doc"
		doc=$(echo $doc | sed -r "s/\t//g")
		kb_hantei=-1		
		if [[ $sub_kensaku_kb -lt 2 ]];then 
			if [[ $doc == *"No results found"* ]];then
				doc=$(echo $doc | grep "No results found")
				doc=$(echo $doc | sed -r "s/^.*(No\ results\ found).*$/\1/")
			else
				kb_hantei=1
				doc=$(echo $doc | grep "<a href" | grep "view" | grep "title" | grep -v "<th" | grep -v "中文字幕" )
				echo "1==============================="
				echo $doc
				echo "1==============================="
				doc=$(echo $doc | grep -E '[ぁ-んァ-ン]' )
				echo $doc
				doc=$(echo $doc | grep "<a href" | grep "view" | grep "title" | grep -v "<th" | grep -v "中文" |  head -n 1)
				echo "2==============================="
				echo $doc
				echo "2==============================="
				doc=$(echo $doc | sed -r "s/^.*<a.*title=\"(.*)\">.*<\ a>.*$/\1/")
				echo "結果0:$doc"	
				#"💖
			fi
			doc=$(echo $doc | tr [a-z] [A-Z])
			doc=$(echo $doc | sed -r "s/^\ \{1,3\}//")
			doc=$(echo $doc | sed -r "s/💖//g")
			doc=$(echo $doc | sed -r "s/UNCENSORED_LEAKED_NOWATERMARK//g")
			#_UNCENSORED_LEAKED_NOWATERMARK
			doc=$(echo $doc | sed -r "s/\[JAV\]//g")
			doc=$(echo $doc | sed -r "s/\[Uncensored\]//g")
			doc=$(echo $doc | sed -r "s/\[[0-9]{3,4}P\]//g")
			doc=$(echo $doc | sed -r "s/\[.*\]//g")
			doc=$(echo $doc | sed -r "s/　//g")
			doc=$(echo $doc | sed -r "s/\ \{2,9\}/_/g")
			doc=$(echo $doc | sed -r "s/\ /_/g")
			doc=$(echo $doc | sed -r "s/\+\+\+_//")
			doc=$(echo $doc | sed -r "s/^\_//g")
			doc=$(echo $doc | sed -r "s/\+\+\+_//")
			doc=$(echo $doc | sed -r "s/\#\#\#//")
			doc=$(echo $doc | sed -r "s/^_//g")
			doc=$(echo $doc | sed -r "s/_$//g")
			echo "結果1:$doc"	
			doc=$(echo $doc | sed -r "s/($filenm)/\1_/")
			doc=$(echo $doc | sed -r "s/__/_/g")
		fi		
		if [[ $sub_kensaku_kb -eq 3 ]];then 
			kb_hantei=1
			doc=$(echo $doc | sed -r "s/\ /_/g")
		fi
		echo "結果:$doc"
		
		#======【裏】【表】判定================================
		#sed前後で文字数に変化があれば、対象文字が含まれていると判定する
		motomojisu=${#doc}
		ret=$(echo $doc | sed -r "s/FC2|CARIB|HEYZO|1PON|C0930|PORNHUB|Pornhub|KIN8|10MU|N[0-9]{3,4}//g")
		atomojisu=${#ret}
		echo "元文字$motomojisu"
		echo "先文字$atomojisu"
		if [[ $kb_hantei -eq 1 ]];
		then
			if [[ $motomojisu -ne $atomojisu ]];
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
				doc=$( echo "$doc" | sed -r "s/【裏】N/【裏】TOKYO-HOT-N/" )
				if [[ $doc == *"CARIB"* ]] ;then
					doc=$( echo "$doc" | sed -r "s/-CARIB_カリビアンコム//" )
					doc=$( echo "$doc" | sed -r "s/【裏】/【裏】CARIBBIAN-/" )
				fi

			else
				if [[ $doc == *"No results found"* ]] || [[ $doc == *"No_results_found"* ]] ;
				then
					doc=$( echo "$doc" | sed -r "s/\ /_/g" )
				else
					doc=$( echo "【ＡＶ】$doc")
				fi
			fi
		fi
		domove=1
		if [[ $doc == *"No_results_found"* ]];
		then
			domove=-1
			echo "301ムーブしない $doc===================================================="
		fi
		if [[ $doc == *"No results found"* ]];
		then
			domove=-1
			echo "302ムーブしない $doc===================================================="
		fi



		IFS="$IFS_ORIGINAL"
#		if [[ $doc != *"No results found"* ]] || [[ $doc != *"No_results_found"* ]];
		if [[ $domove -eq 1 ]];
		then
			echo "318 $doc"	
			doc=$(echo $doc | sed -e "s/$/_/")	
			motofile=$(echo $motofile | sed -r "s/hhd800\.com@//g")
			echo "MOTO:$doc$motofile"
			echo "$filenm:$doc" >> "kekka"
			TargetPATH=$(dirname $line)
			echo "$TargetPATH"
			if [[ $line = *"オンライン視聴"* ]];
			then
				echo "309mv:$motofile"
				#$motofile=$(echo "$motofile" | sed -e s/"\].*"// | sed -e s/"\["// | sed -e s/"\[.*\]"// | sed -e s/\ //g )
				echo "310mv:$motofile"
				echo "311mv:$line $TargetPATH/$doc$motofile"
				echo "312mv:$doc$filenm"
				mv "$line" "$TargetPATH/$doc$filenm.mp4" 
			else
				echo "313mv:$line $TargetPATH/$doc$motofile"
				mv "$line" "$TargetPATH/$doc$motofile"
			fi


		fi
		#exit 0 
	fi
#done < ./$out_file
done << END 
$array
END
exit 0		

IFS="$IFS_ORIGINAL"
#=======テンポラリィーファイル削除===========
MotoPath=$(pwd)
cd $(dirname $0)
NowPath=$(pwd)
echo "元：$MotoPath"
echo "今：$NowPath"
rm -f "$NowPath/filelist"
rm -f "$NowPath/test"
rm -f "$NowPath/working"

exit 0

#================空フォルダー削除============
echo "空フォルダー削除"
TargetPATH=$("$HOME/Downloads")
cd /Users/asaihiroyuki/Downloads

echo "$(pwd)"
NowPath=$(pwd)
array=$(ls -l | grep ^d | awk {'print $9 | "sort"'})
echo "===ディレクトリー 一覧表示"
while read line
do
	echo "$line"
	files=$(find $NowPath/$line -type f -maxdepth 1 -name \*.mp4 -o -name \*.mov -o -name \*.mkv -o -name \*.MP4 -o -name \*.part)
	echo "$files"
	if [[ ${#files} -lt 1 ]]
	then
		echo "削除対象:$NowPath/$line"
		rm -rf $NowPath/$line
	fi


done << END 
	$array
END




exit 0


#! /bin/bash 

echo "Starting..."

RACINE="http://interfacelift.com"
folder="INTERFACELIFT"
TEMPfile1="TEMPinterfacelift"
TEMPfile2="TEMPinterfacelift2"

maxPage=365
# categories=('hdtv/1080p' 'netbook/1280x800');
categories=('hdtv/1080p');

if ! test -d $folder;then mkdir $folder;fi
cd $folder

for category in "${categories[@]}"
do

	for page in `seq 1 $maxPage`
	do
		# Get the HTML page
		URL=$RACINE"/wallpaper/downloads/date/"$category"/index"$page".html"
		echo "Getting $URL"
		wget -q --user-agent="Opera" --output-document=$TEMPfile1 $URL

		# Look for a wallpaper pattern (one by image)
		# /wallpaper/7yz4ma1/02923_kangarooislandlighthouse_1920x1080.jpg
		cat $TEMPfile1 | grep -o -P "\/wallpaper\/(?!previews)[a-z0-9]+\/[0-9]+_[a-z]+_[0-9]{3,4}x[0-9]{3,4}\\.jpg" > $TEMPfile2

		for i in `cat $TEMPfile2`
		do
			#filename=`echo $i | cut -d / -f 4`
			filename=nope

			if ! test -f $filename
			then
				echo $RACINE$i
				wget -q --user-agent="Opera" $RACINE$i
			else
				echo "$filename already here"
			fi
		done

		rm $TEMPfile1
		rm $TEMPfile2
	done

done

cd ..

echo "...done!"


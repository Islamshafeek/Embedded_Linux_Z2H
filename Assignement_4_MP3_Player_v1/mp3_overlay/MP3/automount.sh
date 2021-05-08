#!/bin/sh


Songslist="/Songs/songslist"

while :

do


#For Unmounting
   	 for dire in $(ls /media/sd*[0-9]); do
		Device="/dev/$(basename $dire)"
   	     	if [ -d "$Device" ]
 			then
			echo " ${Device} Connected.."
            		cd /Songs
			ls *.mp3 > $songsFile
			cd /media/$dire
            		ls *.mp3 >> $songsFile
 			else
            		umount $dire 2> /dev/null
            		rm -r $dire
        	fi
    	done


# For Mounting
	for Device in $(ls /dev/sd*[0-9])
	do
		if [ $(df | grep -c $Device) -eq 0 ]
 			then
			dire="/media/$(basename $Device)"
		 		if [ -d "$dire" ]
				then
  			# Take action if $DIR exists. #
  					echo " ${dire} exist..." 
  				#cd $dire	
  				#ls *.mp3 >> $Songslist	
 				else
  					echo "${dire} not exists..."
  					mkdir /media/$(basename $Device)
  					mount $Device $dire
  					cd $dire	
  					ls *.mp3 >> $Songslist
 				fi
			else 
				echo "${Device} is mounted..."
				
		fi	
	done


done

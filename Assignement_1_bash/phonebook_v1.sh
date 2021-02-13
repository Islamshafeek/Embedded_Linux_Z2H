#!/bin/bash

#set -x


file_path="./phonebook_v1.sh"
op=$1
op=${op,,}   #Convert input paramter to lowercase


#Display all Function...........................................................................
function displayAll {
grep -E "^[a-zA-Z\ ]+,[0-9]+$" $file_path || echo "No Contacts!" 
}

function insert {
read -p "Enter New Name: " newcontact
if [[ $newcontact =~ ^[a-zA-Z\ ]+$ ]] 
then
	if  grep -E "^$newcontact,[0-9]+$" $file_path > /dev/null
	then
	echo "Contact already exists!"
	else
	read -p "Enter New Number: " newnumber
		if [[ $newnumber  =~ ^[0-9]+$ ]] && [ ${#newnumber} -eq 11 ]
		then 
			if  grep -E "^[a-zA-Z\ ]+,$newnumber$" $file_path > /dev/null
			then
        		echo "Number already exists!"
			else 
			echo "$newcontact,$newnumber" >> $file_path
			fi
		else
		echo "Not Valid Number!"
		fi
	fi
else 
echo "Not Valid Name!"
fi
}
#................................................................................................

#Search Function................................................................
function search {
read -p "Enter Name: " searchcontact
grep -E "^$searchcontact,[0-9]+$" $file_path || echo "Not Found!"
#grep -E "^$searchcontact" $file_path || echo "Not Found!"
}
#...............................................................................

#deleteAll Functiom.............................................................
function deleteAll {
read -p "Are you Sure? [y] [n]: " check
check=${check,,}
case $check in 
y)
sed -i -r '/^[a-zA-Z\ ]+,[0-9]+/,/^$/d' $file_path
echo "All contacts are deleted!!!";;
n)exit 0;;
*)echo "Not Valid!!...Enter [y] or [n]"
deleteAll;;
esac
}
#..............................................................................

#delete By Name Function.......................................................
function deleteName {
read -p "Enter Name: " deletecontact
if grep -E "^$deletecontact,[0-9]+$" $file_path > /dev/null
then
sed -i -r "/^$deletecontact,[0-9]/d" $file_path 
else 
echo "Not Found!"
fi
}
#..............................................................................

#Check on Input Parameters Function............................................
function checkInput {
case $op in     #check if input is valid 
"-i")
insert;;
"-v")
displayAll;;
"-s")
search;;
"-e")
deleteAll;;
"-d")
deleteName;;
*)
echo "Wrong Input";;
esac
}
#..............................................................................


#Start of code:

#check on number of input parameters...........................................
case $# in
1)checkInput;;
0)echo "No Input Parameters";;
*)echo "Exceeds parameters limit!";;
esac
#..............................................................................

#set +x

exit 0


#Beginning of PhonebookDB......................................................


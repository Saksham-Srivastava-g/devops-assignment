#!/bin/bash

addDir(){
	local dirName="$2"
	local parentDir="$1"
	
	if [[ -z "$parentDir" || -z "$dirName" ]]; then
		echo " $0 : Please give the correct argunments, parentDir or dirName is empty"
		exit 1
	fi
	if [[ ! -d "$parentDir" ]]; then
		echo "Error: Parent dir does not exist."
		read -p "Do you want to make $parentDir ?y/n" answer
		if [ [ "$answer" == "y" ] ]; then
			mkdir -p "$parentDir"
			echo "Parent directory made: $parentDir"
		else
			echo "Exiting code without creating $parentDir"
			exit 1
		fi
	fi

	if [[ -d "$parentDir/$dirName" ]]; then
		echo " Director $dirName already exists in $parentDir"
		exit 1
	else
		mkdir -p "$parentDir/$dirName"
		echo "Dir made successfully"
	fi
}

deleteDir(){
	local dirName="$2"
        local parentDir="$1"

        if [[ -z "$parentDir" || -z "$dirName" ]]; then
                echo " $0 : Please give the correct argunments, parentDir or dirName is empty"
                exit 1
        fi
	
	if  [ ! -d "$parentDir/$dirName" ]; then
		echo "$parentDir/$dirName does not exist"
		exit 1
	else
		rmdir "$parentDir/$dirName" 2>/dev/null
		if [[ $? -eq 0 ]]; then
			echo "Dir deleted successfully"
		else
			read -p "Dir is not empty, do you want to force delete it?, y/n" answer
			if [[ "$answer" = "y" ]]; then
				rm -rf "$parentDir/$dirName"
			else
				echo "Exiting code without deleting $parentDir/$dirName "
			fi
		fi
	fi
}

listAll(){
	local dirName="$2"
        local parentDir="$1"

        if [[ -z "$parentDir" || -z "$dirName" ]]; then
                echo " $0 : Please give the correct argunments, parentDir or dirName is empty"
                exit 1
        fi
	
	 if  [ ! -d "$parentDir/$dirName" ]; then
                echo "$parentDir/$dirName does not exist"
                exit 1
        else
		echo "Dir contents are ->:"
		ls -l "$parentDir/$dirName"
	fi
}

listOnlyFiles(){
	local dirName="$2"
        local parentDir="$1"

        if [[ -z "$parentDir" || -z "$dirName" ]]; then
                echo " $0 : Please give the correct argunments, parentDir or dirName is empty"
                exit 1
        fi

        if  [ ! -d "$parentDir/$dirName" ]; then
                echo "$parentDir/$dirName does not exist"
                exit 1
	else
		ls -l "$parentDir/$dirName" | grep '^-'
	fi	
}

listOnlyDir(){
        local dirName="$2"
        local parentDir="$1"

        if [[ -z "$parentDir" || -z "$dirName" ]]; then
                echo " $0 : Please give the correct argunments, parentDir or dirName is empty"
                exit 1
        fi

        if  [ ! -d "$parentDir/$dirName" ]; then
                echo "$parentDir/$dirName does not exist"
                exit 1
        else
                ls -l "$parentDir/$dirName" | grep '^d'
        fi      
}
	
createFile(){
	local dirName="$1"
	local fileName="$2"

	if [[ -z "$dirName" || -z "$fileName" ]]; then
		echo "$0 : Please give the correct argunments, dir or filename is empty "
		exit 1
	fi

	if [[ ! -d "$dirName" ]]; then
		read -p "$0 : This directory does not exist do you want me to make it? y/n : " answer

		if [[ "$answer" = "y" ]]; then
			mkdir -p "$dirName"
			echo "Directory Created"
		fi

		exit 1
	fi
	
	touch "$dirName/$fileName" 2>/dev/null
	
	if [ $? -eq 0 ]; then
		echo "File created successfully"
	else
		echo "Some error occurred"
	fi
}

addContent(){
	
	local dir=$1
	local fileName=$2
	local content=$3

	if [[ -z "$dir" || -z "$fileName" || -z "$content" ]]; then
		echo "$0 : please check your argunment correctly, they are empty. "
		exit 1
	fi

	if [ ! -d "$dir" ]; then
		echo "$0 : $dir do not exist"
	fi
	
	echo "$content" >> "$dir/$fileName"
	
	echo "Content added successfully"

}

addContentOnTop(){
	
	local dir=$1
        local fileName=$2
        local content=$3

        if [[ -z "$dir" || -z "$fileName" || -z "$content" ]]; then
                echo "$0 : please check your argunment correctly, they are empty. "
                exit 1
        fi

        if [ ! -d "$dir" ]; then
                echo "$0 : $dir do not exist"
        fi

        sed -i "1i $content" "$dir/$fileName"

        echo "Content added successfully on top"
}

showTopNLines(){
	local dir=$1
        local fileName=$2
        local lines=$3

        if [[ -z "$dir" || -z "$fileName" || -z "$lines" ]]; then
                echo "$0 : please check your argunment correctly, they are empty. "
                exit 1
        fi

        if [ ! -d "$dir" ]; then
                echo "$0 : $dir do not exist"
        fi

	head -n "$lines" "$dir/$fileName" 

}

showLastNLines(){
	local dir=$1
        local fileName=$2
        local lines=$3

        if [[ -z "$dir" || -z "$fileName" || -z "$lines" ]]; then
                echo "$0 : please check your argunment correctly, they are empty. "
                exit 1
        fi

        if [ ! -d "$dir" ]; then
                echo "$0 : $dir do not exist"
        fi

        tail -n "$lines" "$dir/$fileName"

}

showSpecificLine(){
	local dir=$1
        local fileName=$2
        local line=$3

        if [[ -z "$dir" || -z "$fileName" || -z "$lines" ]]; then
                echo "$0 : please check your argunment correctly, they are empty. "
                exit 1
        fi

        if [ ! -d "$dir" ]; then
                echo "$0 : $dir do not exist"
        fi

        awk "NR==$line" "$dir/$fileName"
}

showLinesInRage(){
	local dir=$1
        local fileName=$2
        local start_line=$3
	local end_line=$4

        if [[ -z "$dir" || -z "$fileName" || -z "$lines" ]]; then
                echo "$0 : please check your argunment correctly, they are empty. "
                exit 1
        fi

        if [ ! -d "$dir" ]; then
                echo "$0 : $dir do not exist"
        fi

	awk "NR>=$start_line && NR<=$end_line" "$dir/$fileName"
}

copyFile(){
	local oFileDir=$1
	local cFileDir=$2

	if [[ -z "$oFileDir" || -z "$cFileDir" ]]; then
		echo "$0 : please check your argunment correctly, they are empty. "
                exit 1
	fi

	cp "$oFileDir" "$cFileDir"
}

deleteFile(){
	local fileDir=$1

	if [ -z "$fileDir" ]; then
		echo "$0 : please check your argunment correctly, they are empty. "
                exit 1
	fi

	rm -f "$fileDir"
}

case $1 in 
	addDir)
		addDir "$2" "$3"
		;;
	delDir)
		deleteDir "$2" "$3"
		;;
	listAll)
		listAll "$2" "$3"
		;;
	listOnlyFiles)
		listOnlyFiles "$2" "$3"
		;;
	listOnlyDir)
		listOnlyDir "$2" "$3"
		;;
	createFile)
		createFile "$2" "$3"
		;;
	addContent)
		addContent "$2" "$3" "$4"
		;;
	addContentOnTop)
		addContentOnTop "$2" "$3" "$4"
		;;
	showTopNLines)
		showTopNLines "$2" "$3" "$4"
		;;
	showLastNLines)
		showLastNLines "$2" "$3" "$4"
		;;
	showSpecificLine)
		showSpecificLine "$2" "$3" "$4"
		;;
	showLinesInRange)
		showLinesInRange "$2" "$3" "$4" "$5"
		;;
	copyFile)
		copyFile "$2" "$3"
		;;
	deleteFile)
		deleteFile "$2"
		;;
	*)
		echo "Invalid Command"
		exit 1
		;;
esac

#!/bin/bash

operation=$1


case $operation in
	createBranch)
		createBranch() $2
		echo "Branch created"
		;;
	
	list)
		listBranches()
		echo "All branches listed"
		;;
	merge)

		mergeBranches() $2
		echo "Branches merged"
		;;

	rebase)

		rebase() $2
		echo "Branches rebased"
		;;

	delete)

		deleteBranch() $2
		echo "Branch deleted"
		;;

	*)
		echo "$0: Please check the argunment"

esac

createBranch(){
	local branch=$1
	
	git branch "$2"
	
}

listBranches(){
	git branch -a
}

mergeBranches(){
	git checkout main
	git merge "$1"
}

rebase(){
	
	git checkout main
	git rebase "$1"

}

deleteBranch(){
	
	git branch -d "$1"
		
}

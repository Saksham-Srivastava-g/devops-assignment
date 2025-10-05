#!/bin/bash


t1(){
	for (( row=1; row<=$1; row++ ))
	do
        	for (( spaces=1; spaces<=($1-row); spaces++ ))
        	do
                	echo -n " "
        done

        for (( star=1; star<=(row); star++ ))
        	do
                	echo -n "*"
        done

        echo
	done
}

t2(){

	for (( row=1; row<=$1; row++ ))
	do
        	for (( col=1; col<=row; col++ ))
        	do
                	echo -n "*"
        	done
        echo
	done
}

t3(){
	for (( row=1; row<=$1; row++ ))
	do
        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done

        	for (( star=1; star<=((2*row)-1); star++ ))
        	do
                	echo -n "*"
        	done

        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done
        	echo
	done
}

t4(){
	for (( row=$1; row>=1; row-- ))
	do
        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done

        	for (( star=1; star<=((2*row)-1); star++ ))
        	do
                	echo -n "*"
        	done

        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done
        	echo
	done
}

t5(){
	
	for (( row=1; row<=$1; row++ ))
	do
        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done

        	for (( star=1; star<=((2*row)-1); star++ ))
        	do
                	echo -n "*"
        	done

        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done
        	echo
	done

	for (( row=($1-1); row>=1; row-- ))
	do
        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done

        	for (( star=1; star<=((2*row)-1); star++ ))
        	do
                	echo -n "*"
        	done

        	for (( space=1; space<=($1-row); space++ ))
        	do
                	echo -n " "
        	done
        echo
	done
}

t6(){
	for (( row=1; row<=$1; row++ ))
	do
        	for (( stars=5; stars>=row; stars-- ))
        	do
                	echo -n "*"
        	done
        echo
	done
}

t7(){
	for (( row=1; row<=$1; row++ ))
	do
        	for (( spaces=0; spaces<row; spaces++ ))
        	do
                	echo -n " "
        	done

        	for (( star=0;  star<=($1-row); star++ ))
        	do
                	echo -n "*"
        	done
        echo
	done
}

task=$2

case $task in
    t1)
	    t1 "$1"
        ;;
    t2)
	    t2 "$1"
        ;;
    t3)
	    t3 "$1"
        ;;
    t4)
	    t4 "$1"
        ;;
    t5)
	    t5 "$1"
        ;;
    t6)
	    t6 "$1"
        ;;
    t7)
	    t7 "$1"
    	    ;;
    *)
        echo "Invalid input, please enter between t1 - t7"
        ;;
esac




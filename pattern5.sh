#!/bin/bash


for (( row=1; row<=5; row++ ))
do
        for (( space=1; space<=(5-row); space++ ))
        do
                echo -n " "
        done

        for (( star=1; star<=((2*row)-1); star++ ))
        do
                echo -n "*"
        done

        for (( space=1; space<=(5-row); space++ ))
        do
                echo -n " "
        done
        echo
done

for (( row=4; row>=1; row-- ))
do
        for (( space=1; space<=(5-row); space++ ))
        do
                echo -n " "
        done

        for (( star=1; star<=((2*row)-1); star++ ))
        do
                echo -n "*"
        done

        for (( space=1; space<=(5-row); space++ ))
        do
                echo -n " "
        done
        echo
done

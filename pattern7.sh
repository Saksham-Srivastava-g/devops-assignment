#!/bin/bash

for (( row=1; row<=5; row++ ))
do
        for (( spaces=0; spaces<row; spaces++ ))
        do
                echo -n " "
        done

        for (( star=0;  star<=(5-row); star++ ))
        do
                echo -n "*"
        done
        echo
done

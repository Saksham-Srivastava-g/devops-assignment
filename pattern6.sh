#!/bin/bash

for (( row=1; row<=5; row++ ))
do
        for (( stars=5; stars>=row; stars-- ))
        do
                echo -n "*"
        done
        echo
done

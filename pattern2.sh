#/bin/bash

for (( row=1; row<=5; row++ ))
do
        for (( col=1; col<=row; col++ ))
        do
                echo -n "*"
        done
        echo
done

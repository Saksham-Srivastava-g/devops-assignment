#!/bin/bash

count=1
while [ $count -lt 6 ]; do
        echo "Stopwatch : $count second passed"
        count=$((count+1))
done

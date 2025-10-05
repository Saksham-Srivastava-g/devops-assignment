#!/bin/bash

list=apple,banana,mango,cherry,orange

for i in {1..5}; do
        echo "$list" | awk -F ',' -v idx="$i" '{ print $idx }'
done

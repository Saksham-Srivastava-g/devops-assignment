#!/bin/bash

num1=$1
operator=$2
num2=$3

case $operator in
        +)
                echo $((num1 + num2))
                ;;
        -)
                echo $((num1 - num2))
                ;;
        \*)
                echo $((num1 * num2))
                ;;
        /)
                if [ "$num2" -eq 0 ]; then
                        echo "Num2 cannot be 0"
                        exit 1
                fi

                echo $((num1 / num2))
                ;;
        *)
                echo "Invalid Operator"
                exit 1
esac

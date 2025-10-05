for (( row=1; row<=5; row++ ))
do
        for (( spaces=1; spaces<=(5-row); spaces++ ))
        do
                echo -n " "
        done

        for (( star=1; star<=(row); star++ ))
        do
                echo -n "*"
        done

        echo
done

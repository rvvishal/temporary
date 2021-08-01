if [[ $1 == "" ]]
then
    echo "must mention trigger reason"
else
    echo "#$(date) $1" >> trigger
    git add *
    git commit -m "$1"
    git push
fi

#lun. 02 août 2021 01:19:16 CEST test sync (source side)

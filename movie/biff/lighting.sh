cat film.csv |awk -F ',' '$NF==1 || ($NF==2 || $NF==3){print $1,$NF}'  |sort -n -k1 

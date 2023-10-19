#!/bin/bash
> node.csv

:<< EOF
1.csv content is as follows:
IP,node,module-1,module-2,module-3,module-4,module-5,module-6
1.1.1.1,source-hebei,source-ceph,,,,,
1.1.1.2,source-hebei,source-ceph,,,,,
1.1.1.3,source-hebei,source-mysql,source-redis,source-mongodb,,,
EOF

dos2unix 1.csv
cat 1.csv |while read line
do
        for i in $(echo ${line} |awk -F "," 'NF==2{i="N/A";print i}NF>2{for(i=3;i<=NF;i++) print $i}')
        do
                echo ${line} |awk -v role="${i}" -F "," 'OFS=","{print $1,$2,role}' >> node.csv
        done
done

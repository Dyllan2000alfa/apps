for i in $(cat ./to-mirror.txt); do

    PLAIN=${i##*/}
    PLAIN=$( echo $PLAIN | cut -d':' -f1 )
    TAG=$( echo $PLAIN | cut -d':' -f2 )
    CLEANTAG=${TAG//$'\r'/}
    CLEAN=${PLAIN//$'\r'/}
    echo ${CLEAN##*|}
    cp -rf templates/app/* charts/dev/${CLEAN}
    sed -i "s|CHARTNAME|${CLEAN}|g" charts/dev/${CLEAN}/Chart.yaml
    sed -i "s|CHARTNAME|${CLEAN}|g" charts/dev/${CLEAN}/values.yaml
    sed -i "s|CHARTTAG|${CLEANTAG}|g" charts/dev/${CLEAN}/values.yaml
    done

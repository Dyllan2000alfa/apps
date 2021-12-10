#!/usr/bin/env bash

# The format of the to-app.txt file is as follows:
# PORT:tccr.io/truecharts/CHART:TAG

for i in $(cat to-app.txt); do

    PLAIN=${i##*/}
    PORT=$( echo $i | cut -d':' -f1 )
    PLAIN=$( echo $PLAIN | cut -d':' -f1 )
    TAG=$( echo $PLAIN | cut -d':' -f2 )
    CLEANTAG=${TAG//$'\r'/}
    CLEANPORT=${PORT//$'\r'/}
    CLEAN=${PLAIN//$'\r'/}
    echo ${CLEAN##*|}
    cp -rf templates/app/* charts/dev/${CLEAN}
    sed -i "s|CHARTNAME|${CLEAN}|g" charts/dev/${CLEAN}/Chart.yaml
    sed -i "s|CHARTNAME|${CLEAN}|g" charts/dev/${CLEAN}/values.yaml
    sed -i "s|CHARTTAG|${CLEANTAG}|g" charts/dev/${CLEAN}/values.yaml
    sed -i "s|CHARTPORT|${CLEANPORT}|g" charts/dev/${CLEAN}/values.yaml
    sed -i "s|CHARTPORT|${CLEANPORT}|g" charts/dev/${CLEAN}/questions.yaml
    done

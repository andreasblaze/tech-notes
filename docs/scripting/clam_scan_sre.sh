#!/bin/bash

#   for cron configuration use    0 0 * * * /usr/lib/clamav-signatures/clam_scan_sre.sh random
#   -rwxr-xr-x 1 root root 3.2K Mar 11 13:00 /usr/lib/clamav-signatures/clam_scan_sre.sh


LOG_PATH=/var/clamav/logs
log_name=$(date -Im)_clamscan.log
SIGNATURES_PATH=/usr/lib/clamav-signatures

S3_LINK=https://signature-rule-distribution.s3.amazonaws.com/****

flock_url=https://api.flock.com/hooks/sendMessage/
FLOCK_TOKEN=****
CHANNEL_URL=${flock_url}${FLOCK_TOKEN}

host=$(hostname)


#1) если параметр == random, то это рандомное значение
#2) если нет входящих параметров или передан 0, то задержка = 0 сек
#3) Если есть число, оно больше 0 и меньше 7200, то это фиксированное значение задержки в сукундах
#4) если параметров больше 1го или значение больше 7200, то выводим ошибку и завершаем скрипт


if [ $# -eq 1 ] && [ "$1" == "random" ]    # Check if there is the only one argument and it's == "random". Than use random value >0 and <7200
then
        WaitPeriod=$(($RANDOM%7200))
                echo "value is random and = $WaitPeriod"
elif [ $# -eq 0 ] || [ $1 -eq 0 ]              # Check if argument don't exist or it equals 0. Run script immediately.
then
        WaitPeriod=0
                echo "value is $WaitPeriod"
elif [ $# -eq 1 ] && [ $1 -lt 7200 ]         # Check if it's the only one argument and it's lower than 7200. Run script after specified seconds.
then
        WaitPeriod=$1
                echo "value is $WaitPeriod"
elif [ $# -gt 1 ] || [ $1 -gt 7201 ]                            # If there are more that 1 argument or it's bigger than 7201 than exit
then
                echo "Vy vveli bol'she 2 argumentov ili znachenie > 7200"
                exit 1
fi


#WaitPeriod=$(($RANDOM%7200)) # generate 2 hour jitter
echo "Waiting $WaitPeriod seconds before scan"
sleep $WaitPeriod


find ${LOG_PATH} -name "*.log" -type f -mtime +30 -exec rm -f {} \; #delete logs created 30+ days ago


mkdir -p ${SIGNATURES_PATH}
mkdir -p ${LOG_PATH}


#wget -N -P ${SIGNATURES_PATH} ${MIRROR_LINK}/securiteinfo.hdb --no-check-certificate
#wget -N -P ${SIGNATURES_PATH} ${MIRROR_LINK}/securiteinfoascii.hdb --no-check-certificate
#wget -N -P ${SIGNATURES_PATH} ${MIRROR_LINK}/securiteinfo.ign2 --no-check-certificate
#wget -N -P ${SIGNATURES_PATH} ${MIRROR_LINK}/securiteinfo0hour.hdb --no-check-certificate
#wget -N -P ${SIGNATURES_PATH} ${MIRROR_LINK}/securiteinfo.mdb --no-check-certificate


wget -N -P ${SIGNATURES_PATH} ${S3_LINK}/clamav_custom.hdb
wget -N -P ${SIGNATURES_PATH} ${S3_LINK}/clamav_custom.ndb
wget -N -P ${SIGNATURES_PATH} ${S3_LINK}/clamav_custom.yar
wget -N -P ${SIGNATURES_PATH} ${S3_LINK}/expl_log4j_cve_2021_44228.yar


ionice -c3 nice -n 19 clamscan --infected --heuristic-alerts=no --cross-fs=yes --exclude-dir=^/usr/lib/clamav-signatures --exclude-dir=/var/lib/clamav/ --exclude-dir=^/sys --exclude-dir=^/proc --exclude-dir=${SIGNATURES_PATH} --database=${SIGNATURES_PATH} --recursive=yes --allmatch=no --log=${LOG_PATH}/${log_name} /

clamscan_exit_code=$?

summary=$(tail -n11 ${LOG_PATH}/${log_name} | sed -z 's/\n/<br>/g')

if [ ${clamscan_exit_code} -eq 1 ];
then
echo "Viruses found"
#post to Flock room if viruses are found
curl -X POST ${CHANNEL_URL} -H "Content-Type: application/json" -d "{'flockml':'<flockml>Clamav scan results for: <b>${host}</b><br>Date: $(date -Im)<br>Results: ${summary}</flockml>'}"
fi

chmod o+r ${LOG_PATH}/${log_name}

# post results to "SRE SHIFT - clamscan results" Flock room
#curl -X POST https://api.flock.com/hooks/sendMessage/**** -H "Content-Type: application/json" -d "{'flockml':'<flockml>Clamav scan results for: <b>${host}</b><br>Date: $(date -Im)<br>Results: ${summary}</flockml>'}"
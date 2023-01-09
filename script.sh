#!/usr/local/bin/bash
cd /app/watch
LINE="-----------------------------------------------------------"
echo ${LINE}
echo "REMOVER has been started and is watching now the directory"
echo ${LINE}
echo "          TZ           =     ${TZ}"
echo "          PATTERN      =     ${PATTERN}"
echo "          INTERVAL     =     ${INTERVAL}"
echo ${LINE}
while true
do
	for ITEM in ${PATTERN}
	do
		if [ -e "${ITEM}" ]
		then
			LOG=/app/logs/$(date -I).log
			DATETIME=$(date -R)
			if [ ! -f ${LOG} ]
			then
				touch ${LOG}
				echo "A new log file has been created: ${LOG}"
				echo ${LINE}
			fi
			echo "${DATETIME}" |& tee -a ${LOG}
			echo "'${ITEM}' has been found in the watch directory" |& tee -a ${LOG}
			rm -r -v -f "${ITEM}" |& tee -a ${LOG}
			echo ${LINE} |& tee -a ${LOG}
		fi
	done
	sleep ${INTERVAL}
done
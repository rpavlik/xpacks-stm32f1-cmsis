#! /bin/bash
set -euo pipefail
IFS=$'\n\t'

if [ ! -f xpack.json ]
then
	echo "Must be started in a package root folder."
	exit 1
fi

PDSC_FILE="Keil.STM32F1xx_DFP.pdsc"
TEMPNAME=xpdsc-tmp.json
xcdl pdsc-convert --file ${PDSC_FILE} --output ${TEMPNAME}

# This step requires jq, a command-line json processor: https://github.com/stedolan/jq
cat ${TEMPNAME} | jq -f scripts/adjust-xpdsc.jq > xpdsc.json
rm ${TEMPNAME}
#! /bin/bash
set -euo pipefail
IFS=$'\n\t'

#
# Copyright (c) 2015 Liviu Ionescu.
# This file is part of the xPacks project (https://xpacks.github.io).
#

# https://sourceforge.net/projects/micro-os-plus/files/Vendor%20Archives/STM32/

RELEASE_VERSION="1.4.0"

FAMILY="STM32F1"
GITHUB_PROJECT="rpavlik/xpacks-stm32f1-hal"

RELEASE_VERSION_COMPACT=$(echo ${RELEASE_VERSION} | sed 's/\.//g')
RELEASE_NAME="stm32cube_fw_f1_v${RELEASE_VERSION_COMPACT}"

ARCHIVE_NAME="${RELEASE_NAME}.zip"
ARCHIVE_URL="https://sourceforge.net/projects/micro-os-plus/files/Vendor%20Archives/STM32/${ARCHIVE_NAME}"

LOCAL_ARCHIVE_FILE="/tmp/xpacks/${ARCHIVE_NAME}"

echo "Cleaning previous files..."
for f in *
do
  if [ "${f}" == "scripts" ]
  then
    :
  else
    rm -rf "${f}"
  fi
done

if [ ! -f "${LOCAL_ARCHIVE_FILE}" ]
then
  mkdir -p $(dirname ${LOCAL_ARCHIVE_FILE})
  curl -o "${LOCAL_ARCHIVE_FILE}" -L "${ARCHIVE_URL}"
fi

echo "Unpacking '${ARCHIVE_NAME}'..."
unzip -q "${LOCAL_ARCHIVE_FILE}"

mv STM32Cube_FW_F1*/* .

echo "Removing unnecessary files..."

rm -rf \
_htmresc \
CMSIS/Flash \
CMSIS/Debug \
Documentation \
Drivers/BSP/ \
Drivers/CMSIS/CMSIS?END*.* \
Drivers/CMSIS/index.html \
Drivers/CMSIS/README.txt \
Drivers/CMSIS/Documentation \
Drivers/CMSIS/DSP_Lib \
Drivers/CMSIS/Include \
Drivers/CMSIS/Lib \
Drivers/CMSIS/RTOS \
Drivers/CMSIS/SVD \
Drivers/STM32F?xx_HAL_Driver/ \
MDK \
Middlewares \
Projects \
Utilities \
package.xml
find . -name '*.exe' -exec rm \{} \;

echo "Creating README.md..."
cat <<EOF >README.md
# ${FAMILY} HAL

This project, available from [GitHub](https://github.com/${GITHUB_PROJECT}),
includes the ${FAMILY} HAL files.

## Version

* v${RELEASE_VERSION}

## Documentation

The latest STM documentation is available from
[STM32CubeF1](http://www.st.com/en/embedded-software/stm32cubef1.html.

## Original files

The original files are available in the \`originals\` branch.

These files were extracted from \`${ARCHIVE_NAME}\`.

To save space, the following folders/files were removed:

* all non-portable *.exe files
* \_htmresc
* CMSIS/Flash
* CMSIS/Debug
* Documentation
* Drivers/BSP/
* Drivers/CMSIS/CMSIS?END*.*
* Drivers/CMSIS/index.html
* Drivers/CMSIS/README.txt
* Drivers/CMSIS/Documentation
* Drivers/CMSIS/DSP_Lib
* Drivers/CMSIS/Include
* Drivers/CMSIS/Lib
* Drivers/CMSIS/RTOS
* Drivers/CMSIS/SVD
* Drivers/STM32F?xx_HAL_Driver/
* MDK
* Middlewares
* Projects
* Utilities
* package.xml

## Changes

* none.

EOF

echo
echo Check if ok and when ready, issue:
echo git add -A
echo git commit -m ${ARCHIVE_NAME}

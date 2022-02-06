#!/bin/bash

_CONFIG=/opt/retronas/dialog/retronas.cfg
source $_CONFIG
source ${DIDIR}/common.sh
cd ${DIDIR}
_CACHE=${TDIR}/rn_tools

DROP_ROOT
GET_LANG

rn_tools() {
  source $_CONFIG
  dialog \
    --backtitle "${RN_TITLE}" \
    --title "${RN_TITLE} ${RN_TOOLS} ${RN_MENU}" \
    --clear \
    --menu "${RN_IPADDRESS}: ${MY_IPS} \
    \n
    \n${RN_PLSSRV}" ${MG} 10 \
    "01" "${RN_MAIN_MENU}" \
    "02" "GOG - Download your GOG installers and extras" \
    "03" "Nintendo 3DS QR code generator for FBI homebrew" \
    "05" "ROM import tool via Smokemonster SMDBs" \
    2> $_CACHE
}

clear
while true
do
  rn_tools
  CHOICE=$( cat $_CACHE )
  case ${CHOICE} in
  02)
    # gogrepo
    $SHELL gogrepo.sh
    ;;
  03)
    # 3DS QR
    clear
    ${SUCOMMAND} ${SCDIR}/3ds_qr.sh
    PAUSE
    ;;
  05)
    # ROM import SMDB
    clear
    $SHELL romimport.sh
    ;;
  *)
    exit 1
    ;;
  esac
done

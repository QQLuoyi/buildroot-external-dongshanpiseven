#!/bin/sh

for f in `(test -d @LIBDIR@/swupdate/conf.d/ && ls -1 @LIBDIR@/swupdate/conf.d/; test -d /etc/swupdate/conf.d && ls -1 /etc/swupdate/conf.d) | sort -u`; do
  if [ -f /etc/swupdate/conf.d/$f ]; then
    . /etc/swupdate/conf.d/$f
  else
    . @LIBDIR@/swupdate/conf.d/$f
  fi
done

LINE=$(cat /proc/cmdline)
VAR=$(echo ${LINE:10:9} | awk '{print $1}')
if [ $VAR =  'mmcblk2p3' ]; then
        ROOTFS="rootfs-2"
else
        ROOTFS="rootfs-1"
fi

if test -f /update-ok ; then
        SURICATTA_ARGS="-c 2"
        rm -f /update-ok
else
        SURICATTA_ARGS="-c 1"
fi
CID=`cat cat /sys/devices/platform/soc/58007000.sdmmc/mmc_host/mmc2/mmc2:0001/cid`
MMCCID=("-i Brstm32mp157pro_01-$(echo ${CID:23:9} | awk '{print $1}')")


exec /usr/bin/swupdate -f /etc/swupdate/swupdate.cfg -L -e rootfs,${ROOTFS} -u "${SURICATTA_ARGS} ${MMCCID}"


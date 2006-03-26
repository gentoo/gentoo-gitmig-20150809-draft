# $Header: /var/cvsroot/gentoo-x86/media-video/noad/files/record-20-noad.sh,v 1.1 2006/03/26 23:03:13 hd_brummy Exp $
#
# Joerg Bornkessel <hd_brummy@gentoo.org>
# Mathias Schwarzott <zzam@gentoo.org>
#

source /etc/conf.d/vdraddon.noad

CMD="/usr/bin/noad"

# Parameter to start NoAd
# parameter are "no | liverecord | afterrecord"

[[ ${VDR_USE_NOAD} != "no" ]] || return

# Start NoAd after Record

if [[ "${VDR_USE_NOAD}" == "afterrecord" ]] && [[ "${VDR_RECORD_STATE}" == "after" ]]; then
	
	[[ "${NOAD_AC3}" == "yes" ]] && CMD="${CMD} -a"

	[[ "${NOAD_JUMP}" == "yes" ]] &&	CMD="${CMD} -j"

	[[ "${NOAD_OVERLAP}" == "yes" ]] && CMD="${CMD} -o"

	[[ "${NOAD_MESSAGES}" == "yes" ]] && CMD="${CMD} -O"

	CMD="${CMD} ${NOAD_PARAMETER}"

	${CMD} ${VDR_RECORD_STATE} "${2}" 
fi

# Section for noad on timeshift

if [[ "${VDR_USE_NOAD}" == "liverecord" ]]; then
	
	[[ "${NOAD_AC3}" == "yes" ]] && CMD="${CMD} -a"

	[[ "${NOAD_JUMP}" == "yes" ]] && CMD="${CMD} -j"

	[[ "${NOAD_OVERLAP}" == "yes" ]] && CMD="${CMD} -o"

	[[ "${NOAD_MESSAGES}" == "yes" ]] && CMD="${CMD} -O"

	CMD="${CMD} --online"

	CMD="${CMD} ${NOAD_PARAMETER}"
	
	${CMD} ${VDR_RECORD_STATE} "${2}"
fi

# uncomment for debug
#echo $1 $2 >> /tmp/my-record-log-file

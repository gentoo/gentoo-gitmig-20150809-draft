# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb-firmware/linuxtv-dvb-firmware-2006.11.13.ebuild,v 1.6 2007/07/02 15:21:39 peper Exp $

DESCRIPTION="Firmware files needed for operation of some dvb-devices"
HOMEPAGE="http://www.linuxtv.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

UNSHIELD_DEPEND=">=app-arch/unshield-0.4"
DEPEND="dvb_cards_sp887x? ( ${UNSHIELD_DEPEND} )"

RDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"


# Files which can be fetched from linuxtv.org
PACKET_NAME=dvb-firmwares-1.tar.bz2
PACKET_SRC_URI="http://www.linuxtv.org/downloads/firmware/${PACKET_NAME}"
get_dvb_firmware="${FILESDIR}/get_dvb_firmware-${PV}"

FW_USE_FLAGS=(
# packet
	"or51132"
	"or51132"
	"or51211"
	"usb-a800"
	"dibusb-usb1"
	"dibusb-usb2"
	"usb-dtt200u"
	"usb-umt"
	"usb-vp702x"
	"usb-vp7045"
	"usb-wt220u"
	"ttpci"
# own URL
	"bcm3510"
	"usb-wt220u"
	"usb-wt220u"
	"usb-dib0700"
# get_dvb_firmware
	"sp8870"
	"sp887x"
	"tda1004x"
	"tda1004x"
	"ttusb-dec"
	"ttusb-dec"
	"ttusb-dec"
	"nxt2002"
	"nxt200x"
	"usb-bluebird"
)

FW_FILES=(
# packet
	"dvb-fe-or51132-qam.fw"
	"dvb-fe-or51132-vsb.fw"
	"dvb-fe-or51211.fw"
	"dvb-usb-avertv-a800-02.fw"
	"dvb-dibusb-5.0.0.11.fw"
	"dvb-usb-dibusb-6.0.0.8.fw"
	"dvb-usb-dtt200u-01.fw"
	"dvb-usb-umt-010-02.fw"
	"dvb-usb-vp702x-01.fw"
	"dvb-usb-vp7045-01.fw"
	"dvb-usb-wt220u-01.fw"
	"dvb-ttpci-01.fw"
# own URL
	"dvb-fe-bcm3510-01.fw"
	"dvb-usb-wt220u-02.fw"
	"dvb-usb-wt220u-fc03.fw"
	"dvb-usb-dib0700-01.fw"
# get_dvb_firmware
	"dvb-fe-sp8870.fw"
	"dvb-fe-sp887x.fw"
	"dvb-fe-tda10045.fw"
	"dvb-fe-tda10046.fw"
	"dvb-ttusb-dec-2000t.fw"
	"dvb-ttusb-dec-2540t.fw"
	"dvb-ttusb-dec-3000s.fw"
	"dvb-fe-nxt2002.fw"
	"dvb-fe-nxt2004.fw"
	"dvb-usb-bluebird-01.fw"
)



FW_GET_PARAMETER=(
# packet
	"-"
	"-"
	"-"
	"-"
	"-"
	"-"
	"-"
	"-"
	"-"
	"-"
	"-"
	"-"
# own URL
	"-"
	"-"
	"-"
	"-"
# get_dvb_firmware
	"sp8870"
	"sp887x"
	"tda10045"
	"tda10046"
	"dec2000t"
	"dec2540t"
	"dec3000s"
	"nxt2002"
	"nxt2004"
	"-"
)

FW_URLS=(
# packet
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
	"${PACKET_SRC_URI}"
# own URL
	"http://www.linuxtv.org/downloads/firmware/dvb-fe-bcm3510-01.fw"
	"http://www.linuxtv.org/downloads/firmware/dvb-usb-wt220u-02.fw"
	"http://home.arcor.de/efocht/dvb-usb-wt220u-fc03.fw"
	"http://vaasa.wi-bw.tfh-wildau.de/~pboettch/home/files/dvb-usb-dib0700-01.fw"
# get_dvb_firmware
	"http://www.softwarepatch.pl/9999ccd06a4813cb827dbb0005071c71/tt_Premium_217g.zip"
	"http://www.avermedia.com/software/Dvbt1.3.57.6.zip"
	"http://www.technotrend.de/new/217g/tt_budget_217g.zip"
	"http://www.technotrend.de/new/217g/tt_budget_217g.zip"
	"http://hauppauge.lightpath.net/de/dec217g.exe"
	"http://hauppauge.lightpath.net/de/dec217g.exe"
	"http://hauppauge.lightpath.net/de/dec217g.exe"
	"http://www.bbti.us/download/windows/Technisat_DVB-PC_4_4_COMPACT.zip"
	"http://www.aver.com/support/Drivers/AVerTVHD_MCE_A180_Drv_v1.2.2.16.zip"
	"http://www.linuxtv.org/download/dvb/firmware/dvb-usb-bluebird-01.fw"
)


SRC_URI=""
NEGATIVE_USE_FLAGS=""
NEGATIVE_END_BRACKETS=""
ALL_URLS=""

for ((CARD=0; CARD < ${#FW_USE_FLAGS[*]}; CARD++)) do
	URL="${FW_URLS[CARD]}"

	if [[ -z ${URL} ]]; then
		echo "missing url for ${FW_USE_FLAGS[CARD]}"
		continue
	fi
	SRC_URI="${SRC_URI} dvb_cards_${FW_USE_FLAGS[CARD]}? ( ${URL} )"

	IUSE="${IUSE} dvb_cards_${FW_USE_FLAGS[CARD]}"
	NEGATIVE_USE_FLAGS="${NEGATIVE_USE_FLAGS} !dvb_cards_${FW_USE_FLAGS[CARD]}? ( "
	NEGATIVE_END_BRACKETS="${NEGATIVE_END_BRACKETS} )"
	ALL_URLS="${ALL_URLS} ${URL}"

	GET_PARAM="${FW_GET_PARAMETER[CARD]}"
	if [[ ${GET_PARAM} != "-" ]]; then
		# all with get_dvb_firmware need unzip
		DEPEND="${DEPEND} dvb_cards_${FW_USE_FLAGS[CARD]}? ( app-arch/unzip )"
	fi
done


SRC_URI="${SRC_URI} ${NEGATIVE_USE_FLAGS} ${ALL_URLS} ${NEGATIVE_END_BRACKETS}"

DEPEND="${DEPEND}
	${NEGATIVE_USE_FLAGS}
		${UNSHIELD_DEPEND}
		app-arch/unzip
	${NEGATIVE_END_BRACKETS}"

install_dvb_card() {
	[[ -z ${DVB_CARDS} ]] || use dvb_cards_${1}
}

pkg_setup() {
	#echo SRC_URI=${SRC_URI}
	#echo DEPEND=${DEPEND}
	if [[ -z ${DVB_CARDS} ]]; then
		elog "DVB_CARDS is not set, installing all available firmware files."
	fi
	elog "List of possible card-names to use for DVB_CARDS:"
	echo ${FW_USE_FLAGS[*]}| tr ' ' '\n' | sort | uniq | fmt \
	| while read line; do
		elog "   ${line}"
	done
	elog "If you need another firmware file and want it included create a bug"
	elog "at bugs.gentoo.org."
}

src_unpack() {
	# link all downloaded files to ${S}
	for f in ${A}; do
		[[ -L ${f} ]] || ln -s ${DISTDIR}/${f} ${f}
	done

	# unpack firmware-packet
	if hasq ${PACKET_NAME} ${A}; then
		unpack ${PACKET_NAME}
		# this file has renamed
		mv dvb-usb-dibusb-5.0.0.11.fw dvb-dibusb-5.0.0.11.fw
	fi


	# Adjust temp-dir of get_dvb_firmware
	sed ${FILESDIR}/get_dvb_firmware-${PV} \
		-e "s#/tmp#${T}#g" \
		> get_dvb_firmware
	chmod a+x get_dvb_firmware

	# extract the firmware-files
	for ((CARD=0; CARD < ${#FW_USE_FLAGS[*]}; CARD++)) do
		install_dvb_card ${FW_USE_FLAGS[CARD]} || continue

		GET_PARAM=${FW_GET_PARAMETER[CARD]}
		if [[ ${GET_PARAM} != "-" ]]; then
			[[ -f ${FW_FILES[CARD]} ]] && ewarn "Already existing: ${FW_FILES[CARD]}"
			elog "Extracting ${FW_FILES[CARD]}"
			./get_dvb_firmware ${GET_PARAM}
		fi
	done
}

src_install() {
	cd ${S}
	insinto /lib/firmware

	for ((CARD=0; CARD < ${#FW_USE_FLAGS[*]}; CARD++)) do
		if install_dvb_card ${FW_USE_FLAGS[CARD]}; then
			local FILE=${FW_FILES[CARD]}
			[[ -f ${FILE} ]] || die "File ${FILE} does not exist!"
			doins ${FILE}
		fi
	done
}


# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb-firmware/linuxtv-dvb-firmware-1.ebuild,v 1.7 2006/04/23 19:49:16 zzam Exp $

DESCRIPTION="Firmware files needed for operation of some dvb-devices"
HOMEPAGE="http://www.linuxtv.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dvb_cards_sp887x? ( >=app-arch/unshield-0.4 )"

RDEPEND=""

RESTRICT="nomirror"

S="${WORKDIR}"


# Files which can be fetched from linuxtv.org
PACKET_SRC_URI="http://www.linuxtv.org/downloads/firmware/dvb-firmwares-1.tar.bz2"
get_dvb_firmware="${FILESDIR}/get_dvb_firmware-${PV}"

PACKET_FW_NAMES=(
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
)

PACKET_FW_FILES=(
	"dvb-fe-or51132-qam.fw"
	"dvb-fe-or51132-vsb.fw"
	"dvb-fe-or51211.fw"
	"dvb-usb-avertv-a800-02.fw"
	"dvb-usb-dibusb-5.0.0.11.fw"
	"dvb-usb-dibusb-6.0.0.8.fw"
	"dvb-usb-dtt200u-01.fw"
	"dvb-usb-umt-010-02.fw"
	"dvb-usb-vp702x-01.fw"
	"dvb-usb-vp7045-01.fw"
	"dvb-usb-wt220u-01.fw"
	"dvb-ttpci-01.fw"
)

# firmwares which have to be fetched with get_dvb_firmware
FW_NAMES=(
	"sp8870"
	"sp887x"
	"tda1004x"
	"tda1004x"
	"ttusb-dec"
	"ttusb-dec"
	"ttusb-dec"
	"nxt200x"
)

FW_GET_PARAMETER=(
	"sp8870"
	"sp887x"
	"tda10045"
	"tda10046"
	"dec2000t"
	"dec2540t"
	"dec3000s"
	"nxt2004"
)

FW_FILES=(
	"dvb-fe-sp8870.fw"
	"dvb-fe-sp887x.fw"
	"dvb-fe-tda10045.fw"
	"dvb-fe-tda10046.fw"
	"dvb-ttusb-dec-2000t.fw"
	"dvb-ttusb-dec-2540t.fw"
	"dvb-ttusb-dec-3000s.fw"
	"dvb-fe-nxt2004.fw"
)

FW_URLS=(
	"http://www.technotrend.de/new/217g/tt_Premium_217g.zip"
	"http://www.avermedia.com/software/Dvbt1.3.57.6.zip"
	"http://www.technotrend.de/new/217g/tt_budget_217g.zip"
	"http://www.technotrend.de/new/217g/tt_budget_217g.zip"
	"http://hauppauge.lightpath.net/de/dec217g.exe"
	"http://hauppauge.lightpath.net/de/dec217g.exe"
	"http://hauppauge.lightpath.net/de/dec217g.exe"
	"http://www.aver.com/support/Drivers/AVerTVHD_MCE_A180_Drv_v1.2.2.16.zip"
)


SRC_URI=""
NEGATIVE_USE_FLAGS=""
ALL_URLS=""
NUMBER_OF_USE_FLAGS=0

for ((CARD=0; CARD < ${#PACKET_FW_NAMES[*]}; CARD++)) do
	SRC_URI="${SRC_URI} dvb_cards_${PACKET_FW_NAMES[CARD]}? ( ${PACKET_SRC_URI} )"

	IUSE="${IUSE} dvb_cards_${PACKET_FW_NAMES[CARD]}"
	NEGATIVE_USE_FLAGS="${NEGATIVE_USE_FLAGS} !dvb_cards_${PACKET_FW_NAMES[CARD]}? ( "
	NUMBER_OF_USE_FLAGS=$((NUMBER_OF_USE_FLAGS+1))
done

ALL_URLS="${ALL_URLS} ${PACKET_SRC_URI}"


for ((CARD=0; CARD < ${#FW_NAMES[*]}; CARD++)) do
	URL="${FW_URLS[CARD]}"

	if [[ -z ${URL} ]]; then
		echo "missing url for ${FW_NAMES[CARD]}"
		continue
	fi
	SRC_URI="${SRC_URI} dvb_cards_${FW_NAMES[CARD]}? ( ${URL} )"

	IUSE="${IUSE} dvb_cards_${FW_NAMES[CARD]}"
	NEGATIVE_USE_FLAGS="${NEGATIVE_USE_FLAGS} !dvb_cards_${FW_NAMES[CARD]}? ( "
	NUMBER_OF_USE_FLAGS=$((NUMBER_OF_USE_FLAGS+1))
	ALL_URLS="${ALL_URLS} ${URL}"
	# they all need unzip
	DEPEND="${DEPEND} dvb_cards_${FW_NAMES[CARD]}? ( app-arch/unzip )"
done


SRC_URI="${SRC_URI} ${NEGATIVE_USE_FLAGS} ${ALL_URLS}"

# add closing brackets for negative use flags
for ((NR=0; NR < ${NUMBER_OF_USE_FLAGS}; NR++)) do
	SRC_URI="${SRC_URI} )"
done


install_dvb_card() {
	[[ -z ${DVB_CARDS} ]] || use dvb_cards_${1}
}

pkg_setup() {
	#echo SRC_URI=${SRC_URI}
	#echo DEPEND=${DEPEND}
	if [[ -z ${DVB_CARDS} ]]; then
		einfo "DVB_CARDS is not set, installing all available firmware files."
	fi
	einfo "List of possible card-names to use for DVB_CARDS:"
	echo ${PACKET_FW_NAMES[*]} ${FW_NAMES[*]}| tr ' ' '\n' | sort | uniq | fmt \
	| while read line; do
		einfo "   ${line}"
	done
}

src_unpack() {
	for f in ${A}; do
		case ${f} in
			dvb-firmwares-*)
				unpack ${f}
				;;
			*)
				[[ -L ${f} ]] || ln -s ${DISTDIR}/${f} ${f}
		esac
	done


	cp ${FILESDIR}/get_dvb_firmware-1 get_dvb_firmware
	sed -i get_dvb_firmware \
		-e "s#/tmp#${T}#g"

	# firmwares which have to be downloaded seperately
	for ((CARD=0; CARD < ${#FW_NAMES[*]}; CARD++)) do
		install_dvb_card ${FW_NAMES[CARD]} || continue

		einfo "Extracting ${FW_NAMES[CARD]}"
		./get_dvb_firmware ${FW_GET_PARAMETER[CARD]}
	done
}

src_install() {
	insinto /lib/firmware

	# dvb-firmware packet from linuxtv
	for ((CARD=0; CARD < ${#PACKET_FW_NAMES[*]}; CARD++)) do
		if install_dvb_card ${PACKET_FW_NAMES[CARD]}; then
			doins ${PACKET_FW_FILES[CARD]}
		fi
	done

	# firmwares which have to be downloaded seperately
	for ((CARD=0; CARD < ${#FW_NAMES[*]}; CARD++)) do
		if install_dvb_card ${FW_NAMES[CARD]}; then
			doins ${FW_FILES[CARD]}
		fi
	done
}


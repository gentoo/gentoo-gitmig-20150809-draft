# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bcm43xx/bcm43xx-0.0.1-r20060329.ebuild,v 1.1 2006/03/29 23:49:46 josejx Exp $

inherit linux-mod eutils

FWCUTTER_VERSION="003"

DESCRIPTION="Driver for Broadcom 43xx based wireless network devices"
HOMEPAGE="http://bcm43xx.berlios.de"
SRC_URI="http://tara.shadowpimps.net/~bcm43xx/bcm43xx-snapshots/standalone/${PN}/${PN}-standalone-${PR#r20}.tar.bz2
	http://download.berlios.de/${PN}/${PN}-fwcutter-${FWCUTTER_VERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="debug"
DEPEND=">=net-wireless/ieee80211softmac-0.1-r${PR#r20}"
RDEPEND="${DEPEND}
	>=net-wireless/wireless-tools-28_pre4
	>=sys-apps/hotplug-20040923-r1"

BUILD_TARGETS="modules"
MODULE_NAMES="bcm43xx(net/wireless::drivers/net/wireless/bcm43xx)"

CONFIG_CHECK="NET_RADIO FW_LOADER"
use debug && CONFIG_CHECK="$CONFIG_CHECK DEBUG_FS"
ERROR_NET_RADIO="${P} requires support for \"Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)\"."
ERROR_FW_LOADER="${P} requires \"Hotplug firmware loading support (CONFIG_FW_LOADER)\"."
ERROR_DEBUG_FS="${P} requires Debug Filesystem support (CONFIG_DEBUG_FS) for building with USE=\"debug\"."

FWCUTTER_DIR="${WORKDIR}/bcm43xx-fwcutter-${FWCUTTER_VERSION}"

S="${WORKDIR}/${PN}-standalone-${PR#r20}"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is lt 2 6 15; then
		die "${P} requires a kernel 2.6.15 or newer, sorry."
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# use external headers, fix "no version magic" bug
	epatch ${FILESDIR}/fix-Makefile.patch

	cd "${S}/drivers/net/wireless/${PN}"

	# bcm43xx expects KBUILD_MODNAME as a string; is this a 2.6.16 thing?
	sed -e 's/\<KBUILD_MODNAME\>/"'"${PN}"'"/g' -i *.[ch] || die 'sed failed'
}

src_compile() {
	BUILD_PARAMS="DEBUG=$(use debug && echo y || echo n) KSRC=${KV_DIR} \
		KSRC_OUTPUT=${KV_OUT_DIR} KDIR=${ROOT}/lib/modules/${KV_FULL}/build" \
		linux-mod_src_compile
	cd ${FWCUTTER_DIR}
	make || die "Can't compile fwcutter."
}

src_install() {
	# Install fwcutter
	exeinto /usr/bin
	doexe ${FWCUTTER_DIR}/${PN}-fwcutter
	doman ${FWCUTTER_DIR}/${PN}-fwcutter.1
	dodoc ${FWCUTTER_DIR}/README

	# Install the module
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if [ -f /lib/modules/${KV_FULL}/net/${PN}.ko ]; then
		einfo
		einfo "Modules from an earlier installation detected. You will need to manually"
		einfo "remove those modules by running the following commands:"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/${PN}.ko"
		einfo "  # depmod -a"
		einfo
	fi

	if ! [ -f /lib/firmware/${PN}_microcode2.fw ]; then
		einfo
		einfo "You'll need to use bcm43xx-fwcutter to install the bcm43xx firmware."
		einfo "Please read the bcm43xx-fwcutter readme for more details:"
		einfo "/usr/share/doc/${PN}-${PVR}/README.gz"
		einfo
	fi

	einfo "Please read this forum thread for help and troubleshooting:"
	einfo "http://forums.gentoo.org/viewtopic-t-409194.html"
	einfo
}

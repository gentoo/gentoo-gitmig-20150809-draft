# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2500/rt2500-1.1.0_beta3.ebuild,v 1.9 2006/04/13 22:34:01 genstef Exp $

inherit eutils linux-mod kde-functions
set-qtdir 3

MY_P="${P/_beta/-b}"
DESCRIPTION="Driver for the RaLink RT2500 wireless chipset"
HOMEPAGE="http://rt2x00.serialmonkey.com"
SRC_URI="http://rt2x00.serialmonkey.com/${MY_P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="amd64 ppc x86"
IUSE="qt"
DEPEND="net-wireless/wireless-tools
	qt? ( =x11-libs/qt-3* )"

S=${WORKDIR}/${MY_P}
MODULE_NAMES="rt2500(net:${S}/Module)"
CONFIG_CHECK="NET_RADIO BROKEN_ON_SMP"
BROKEN_ON_SMP_ERROR="SMP Processors and Kernels are currently not supported"
MODULESD_RT2500_ALIASES=('ra? rt2500')


pkg_setup() {
	linux-mod_pkg_setup
	if use_m
	then BUILD_PARAMS="-C ${KV_DIR} M=${S}/Module"
		 BUILD_TARGETS="modules"
	else die "please use a kernel >=2.6.6"
	fi
}

src_compile() {
	sed -i "s:#if RT2500_DBG:#ifdef RT2500_DBG:" Module/oid.h || die "sed failed"

	# Fix module parameter registration
	sed -i 's:MODULE_PARM(debug, "i"):module_param(debug, int, 0):'	Module/rtmp_main.c || die "module parameter sed failed"
	sed -i 's:MODULE_PARM(ifname, "s"):module_param(ifname, charp, 0):'	Module/rtmp_main.c || die "module parameter sed failed"

	if use qt; then
		cd ${S}/Utilitys
		${QTDIR}/bin/qmake -o Makefile raconfig2500.pro
		emake || die "make Utilities failed"
	fi

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	if use qt; then
		dobin ${S}/Utilitys/RaConfig2500
		doicon Utilitys/ico/RaConfig2500.xpm
		make_desktop_entry RaConfig2500 "RaLink RT2500 Config" RaConfig2500.xpm
	fi

	insinto /etc/Wireless/RT2500STA
	doins Module/RT2500STA.dat

	dodoc Module/README Module/TESTING Module/iwpriv_usage.txt THANKS FAQ CHANGELOG
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "to set up the card you can use:"
	einfo "- iwconfig from wireless-tools"
	einfo "- iwpriv, like described in \"/usr/share/doc/${PF}/iwpriv_usage.txt.gz"\"
	einfo "- /etc/Wireless/RT2500STA/RT2500STA.dat, like described in \"/usr/share/doc/${PF}/README.gz\""
	einfo "- RT2500 provided qt API: RaConfig2500"
}

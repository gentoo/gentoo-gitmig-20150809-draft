# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mkxf86config/mkxf86config-0.8-r3.ebuild,v 1.1 2004/07/27 12:39:37 wolf31o2 Exp $

inherit eutils

IUSE="livecd"

MY_PN="xf86config-knoppix"
MY_PV="${PV}-5"
MY_P="${MY_PN}_${MY_PV}"
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="xf86config setup program"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${MY_P}.tar.gz"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
RDEPEND="sys-apps/hwsetup
	sys-apps/ddcxinfo-knoppix
	virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_install() {
	dodoc debian/README.Debian debian/changelog debian/control debian/copyright
	insinto /etc/X11
	doins XF86Config-4.in XF86Config.in xorg.conf.in
	exeinto /usr/sbin
	doexe mkxf86config.sh

	if use livecd; then
		exeinto /etc/init.d
		newexe ${FILESDIR}/mkxf86config-init mkxf86config
	fi
}

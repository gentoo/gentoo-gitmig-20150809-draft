# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ddcxinfo-knoppix/ddcxinfo-knoppix-0.6.ebuild,v 1.1 2004/01/03 17:31:21 port001 Exp $

IUSE=""

DESCRIPTION="Program to automatically probe a monitor for information"
HOMEPAGE="http://www.knopper.net"

MY_PV=${PV}-5
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/glibc"
DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/sbin
	doexe ddcxinfo-knoppix
	dodoc debian/changelog debian/control debian/copyright README COPYING
	doman debian/ddcxinfo-knoppix.1
}

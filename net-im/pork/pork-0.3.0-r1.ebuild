# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pork/pork-0.3.0-r1.ebuild,v 1.1 2003/01/14 04:14:38 lostlogic Exp $

IUSE=""

SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"
DESCRIPTION="Console based AIM client that looks like ircII"
HOMEPAGE="http://dev.ojnk.net/"
LICENSE="GPLv2"

KEYWORDS="~x86"
SLOT="0"
DEPEND="sys-devel/perl
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-help.patch || die
}

src_install() {
	einstall

	dodoc ${FILESDIR}/README.gentoo-${PV}

	doman doc/pork.1
	insinto /usr/share/pork/examples
	doins examples/blist.txt

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README STYLE TODO
}

pkg_postinst() {
	einfo "Please read /usr/share/doc/${PN}-${PVR}/README.gentoo-${PV} for quickstart info."
}

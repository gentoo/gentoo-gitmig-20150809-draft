# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/colorgcc/colorgcc-1.3.2-r3.ebuild,v 1.9 2004/07/14 22:54:09 agriffis Exp $

IUSE=""

inherit eutils

DESCRIPTION="Adds color to gcc output"
HOMEPAGE="http://packages.debian.org/testing/devel/colorgcc.html"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/c/${PN}/${PN}_${PV}-4.2.diff.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~mips"

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${PN}_${PV}.orig.tar.gz

	epatch ${DISTDIR}/${PN}_${PV}-4.2.diff.gz

	# Add support for gcc-config enabled gcc.  You need gcc-config-1.2.7 or
	# later for this ..
	# <azarah@gentoo.org> (25 Dec 2002)
	cd ${S}; epatch ${FILESDIR}/${P}-gcc_config.patch
}

src_compile() {
	echo "Nothing to compile"
}

src_install() {
	exeinto /usr/bin
	doexe colorgcc
	dodir /usr/bin/wrappers
	dosym ../colorgcc /usr/bin/wrappers/gcc
	dosym ../colorgcc /usr/bin/wrappers/g++
	dosym ../colorgcc /usr/bin/wrappers/cc
	dosym ../colorgcc /usr/bin/wrappers/c++
	dosym ../colorgcc /usr/bin/wrappers/${CHOST}-gcc
	dosym ../colorgcc /usr/bin/wrappers/${CHOST}-g++
	dosym ../colorgcc /usr/bin/wrappers/${CHOST}-c++

	dodoc COPYING CREDITS ChangeLog INSTALL colorgccrc
}

pkg_postinst() {
	if grep /usr/bin/wrappers /etc/profile > /dev/null
	then
		einfo "/etc/profile already updated for wrappers"
	else
		einfo "Add this to the end of your ${ROOT}etc/profile:"
		einfo
		einfo "#Put /usr/bin/wrappers in path before /usr/bin"
		einfo 'export PATH=/usr/bin/wrappers:${PATH}'
	fi
}

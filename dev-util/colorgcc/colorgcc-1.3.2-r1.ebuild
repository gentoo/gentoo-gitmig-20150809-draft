# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/colorgcc/colorgcc-1.3.2-r1.ebuild,v 1.14 2004/07/14 22:54:09 agriffis Exp $

DESCRIPTION="Adds color to gcc output"
HOMEPAGE="http://packages.debian.org/testing/devel/colorgcc.html"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/c/${PN}/${PN}_${PV}-4.1.diff.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${PN}_${PV}.orig.tar.gz
	zcat ${DISTDIR}/${PN}_${PV}-4.1.diff.gz | patch -p0
}

src_compile() {
	echo "Nothing to compile"
}

src_install() {
	exeinto /usr/bin
	doexe colorgcc
	dodir /usr/bin/wrappers
	dosym /usr/bin/colorgcc /usr/bin/wrappers/gcc
	dosym /usr/bin/colorgcc /usr/bin/wrappers/g++
	dosym /usr/bin/colorgcc /usr/bin/wrappers/cc
	dosym /usr/bin/colorgcc /usr/bin/wrappers/c++
	dodoc COPYING CREDITS ChangeLog INSTALL colorgccrc
}

pkg_postinst() {
	if grep /usr/bin/wrappers /etc/profile > /dev/null
	then
		echo "/etc/profile already updated for wrappers"
	else
		echo "Add this to the end of your ${ROOT}etc/profile:"
		echo
		echo "#Put /usr/bin/wrappers in path before /usr/bin"
		echo 'export PATH=/usr/bin/wrappers:${PATH}'
	fi
}

# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}/${P}
DESCRIPTION="Adds color to gcc output"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz
http://ftp.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}-4.1.diff.gz"

HOMEPAGE="http://packages.debian.org/testing/devel/colorgcc.html"

DEPEND="sys-devel/perl
	sys-devel/gcc"

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
	echo -e "#Put /usr/bin/wrappers in path before /usr/bin" >> /etc/profile
	echo 'export PATH=/usr/bin/wrappers:${PATH}' >> /etc/profile
	echo '/usr/bin/wrappers added to path in /etc/profile!'
fi
}

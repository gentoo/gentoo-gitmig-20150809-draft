# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cryptcat/cryptcat-20031202.ebuild,v 1.1 2004/02/14 04:59:31 vapier Exp $

inherit eutils

DEB_PVER=2
MY_P=${PN}_${PV}
DESCRIPTION="TCP/IP swiss army knife extended with twofish encryption"
HOMEPAGE="http://farm9.org/Cryptcat/"
SRC_URI="http://farm9.org/Cryptcat/${MY_P}.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cryptcat/${MY_P}-${DEB_PVER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_P}-2.diff
	echo "#define arm arm_timer" >> generic.h
	sed -i 's:#define HAVE_BIND:#undef HAVE_BIND:' netcat.c
	sed -i 's:#define FD_SETSIZE 16:#define FD_SETSIZE 1024:' netcat.c #34250
	sed -i 's:-DGAPING_SECURITY_HOLE::' Makefile # -e doesn't work at all. See http://www.kb.cert.org/vuls/id/165099
}

src_compile() {
	export XFLAGS="-DLINUX"
	export XLIBS="-lstdc++"
	CC="gcc ${CFLAGS}" make -e cryptcat || die
}

src_install() {
	dobin cryptcat || die
	dodoc ChangeLog README README.cryptcat
	doman ${P}/debian/cryptcat.1
}

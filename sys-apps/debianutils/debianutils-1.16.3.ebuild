# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/debianutils/debianutils-1.16.3.ebuild,v 1.2 2002/09/25 22:22:42 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A selection of tools from Debian"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/base/debianutils.html"

KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="GPL-2 BSD SMAIL"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff || die

	# Make installkernel and mkboot more Gentoo friendly
	# <azarah@gentoo.org> (25 Sep 2002)
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {
	if [ -z "`use static`" ]
	then
		pmake || die
	else
		pmake LDFLAGS=-static || die
	fi
}


src_install() {
	into /
	dobin readlink tempfile mktemp

	if [ -z "`use build`" ]
	then
		dobin run-parts
		insopts -m755
		exeinto /usr/sbin
		doexe savelog
		dosbin installkernel
		into /usr
		dosbin mkboot
		
		if [ -z "`use bootcd`" ]
		then
			into /usr
			doman mktemp.1 readlink.1 tempfile.1 run-parts.8 savelog.8 \
				installkernel.8 mkboot.8
			
			cd debian
			dodoc changelog control copyright
		fi
	fi
}


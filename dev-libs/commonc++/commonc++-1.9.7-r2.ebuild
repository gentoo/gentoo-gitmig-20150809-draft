# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++/commonc++-1.9.7-r2.ebuild,v 1.6 2003/09/10 22:20:38 msterret Exp $

S=${WORKDIR}/CommonC++-1.9.7
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"
SRC_URI="http://ftp.azc.uam.mx/mirrors/gnu/commonc++/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commonc++/"

DEPEND="sys-libs/zlib
	dev-libs/libxml2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/commmonc++-0.1.patch || die

}
src_compile() {

	econf || die "./configure failed"
	make DESTDIR=${D} || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL NEWS OVERVIEW.TXT ChangeLog\
		  README THANKS TODO COPYING COPYING.addendum
	dohtml doc/*
}

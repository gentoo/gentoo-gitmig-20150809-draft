# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++/commonc++-1.9.7-r3.ebuild,v 1.1 2003/05/09 03:12:49 heim Exp $

S=${WORKDIR}/${P/commonc/CommonC}
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\ 
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"
SRC_URI="http://ftp.azc.uam.mx/mirrors/gnu/commonc++/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commonc++/"

DEPEND="sys-libs/zlib
	dev-libs/libxml2"
IUSE="ppc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/commmonc++-0.1.patch || die "patch1 failed"
	use ppc && epatch ${DISTDIR}/commonc++_1.9.7-1.diff.gz || die "patch2 failed"
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

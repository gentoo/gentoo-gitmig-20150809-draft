# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++/commonc++-1.9.7-r3.ebuild,v 1.7 2003/10/28 13:07:48 mholzer Exp $

S=${WORKDIR}/${P/commonc/CommonC}
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"
SRC_URI="mirror://gnu/commonc++/${P}.tar.gz
		mirror://gentoo/${P}-1.diff.gz"
HOMEPAGE="http://www.gnu.org/software/commonc++/"

DEPEND="sys-libs/zlib
	dev-libs/libxml2"
IUSE="ppc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.1.patch || die "patch1 failed"
	if [ `use ppc` ]; then
		epatch ${DISTDIR}/${P}-1.diff.gz || die "patch2 failed"
	fi
}
src_compile() {
	econf || die "./configure failed"
	make DESTDIR=${D} || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL NEWS OVERVIEW.TXT ChangeLog \
		README THANKS TODO COPYING*
	dohtml doc/*
}

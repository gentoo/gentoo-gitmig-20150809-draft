# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++/commonc++-1.9.7-r2.ebuild,v 1.11 2004/03/12 02:54:32 mr_bones_ Exp $

inherit eutils

S=${WORKDIR}/CommonC++-1.9.7
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"
SRC_URI="mirror://gnu/commonc++/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commonc++/"

DEPEND="sys-libs/zlib
	dev-libs/libxml2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.1.patch || die
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

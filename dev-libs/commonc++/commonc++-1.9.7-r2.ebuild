# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++/commonc++-1.9.7-r2.ebuild,v 1.15 2004/11/02 22:02:15 gustavoz Exp $

inherit eutils

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
HOMEPAGE="http://www.gnu.org/software/commonc++/"
SRC_URI="mirror://gnu/commonc++/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

DEPEND="sys-libs/zlib
	dev-libs/libxml2"

S="${WORKDIR}/CommonC++-1.9.7"

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

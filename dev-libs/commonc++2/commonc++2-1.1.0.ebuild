# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++2/commonc++2-1.1.0.ebuild,v 1.1 2004/03/12 21:53:23 lu_zero Exp $

IUSE="doc"

MY_P=${P/++/pp}
S=${WORKDIR}/${MY_P}

HOMEPAGE="http://cplusplus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cplusplus/${MY_P}.tar.gz"
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"

RESTRICT="nomirror"

DEPEND="sys-libs/zlib
	dev-libs/libxml2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	econf --prefix=/usr || die "./configure failed"
	emake || die
}

src_install () {
	sed -i -e 's:chmod +x ${scriptdir}:chmod +x $(DESTDIR)${scriptdir}:' src/Makefile
	emake install DESTDIR=${D} install || die
	if use doc ; then
		dohtml doc/html/*
		insinto /usr/share/doc/${PF}/demo
		doins demo/*
	fi
	dodoc AUTHORS ChangeLog COPYING* INSTALL NEWS README THANKS TODO
}

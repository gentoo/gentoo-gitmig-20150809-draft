# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/commonc++2/commonc++2-1.1.0.ebuild,v 1.3 2004/08/21 00:45:51 mr_bones_ Exp $

MY_P=${P/++/pp}
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
HOMEPAGE="http://cplusplus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cplusplus/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="sys-libs/zlib
	dev-libs/libxml2"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --prefix=/usr || die
	emake || die "emake failed"
}

src_install () {
	sed -i \
		-e 's:chmod +x ${scriptdir}:chmod +x $(DESTDIR)${scriptdir}:' \
		src/Makefile \
		|| die "sed failed"
	make DESTDIR="${D}" install || die "make install failed"
	if use doc ; then
		dohtml doc/html/*
		insinto /usr/share/doc/${PF}/demo
		doins demo/*
	fi
	dodoc AUTHORS ChangeLog COPYING* INSTALL NEWS README THANKS TODO
}

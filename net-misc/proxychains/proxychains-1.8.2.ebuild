# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxychains/proxychains-1.8.2.ebuild,v 1.1 2004/03/13 00:51:47 vapier Exp $

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="http://proxychains.sourceforge.net/"
SRC_URI="mirror://sourceforge/proxychains/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""

src_unpack () {
	unpack ${A}
	sed -i 's:/etc/:$(DESTDIR)/etc/:' ${S}/proxychains/Makefile.in || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog README TODO
}

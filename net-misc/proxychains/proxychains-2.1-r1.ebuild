# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxychains/proxychains-2.1-r1.ebuild,v 1.1 2005/03/12 20:39:07 vapier Exp $

inherit eutils

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="http://proxychains.sourceforge.net/"
SRC_URI="mirror://sourceforge/proxychains/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""

src_unpack () {
	unpack ${A}
	sed -i 's:/etc/:$(DESTDIR)/etc/:' "${S}"/proxychains/Makefile.in || die
	epatch "${FILESDIR}"/${P}-libc-connect.patch
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}

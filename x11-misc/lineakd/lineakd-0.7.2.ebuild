# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakd/lineakd-0.7.2.ebuild,v 1.5 2004/11/07 19:50:11 pyrania Exp $

inherit eutils

IUSE="xosd"

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	xosd? ( x11-libs/xosd )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/lkey-cast.patch || die "epatch failed."
}

src_compile() {
	econf `use_with xosd` --with-x || die
	emake || die
}

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${P} install || die
	dodoc AUTHORS COPYING INSTALL README TODO
}

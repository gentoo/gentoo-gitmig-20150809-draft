# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpinboard/wmpinboard-1.0.ebuild,v 1.12 2004/07/20 19:19:27 s4t4n Exp $

inherit eutils

IUSE=""
DESCRIPTION="Window Maker dock applet resembling a miniature pinboard."
SRC_URI="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard/${P}.tar.bz2"
HOMEPAGE="http://www.tu-ilmenau.de/~gomar/stuff/wmpinboard"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64 ~ppc"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/wmpinboard-1.0-segfault.patch
}

src_compile()
{
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install ()
{
	make DESTDIR=${D} install-strip || die "install failed"
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.7.ebuild,v 1.1 2003/03/24 04:20:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An image viewer that uses OpenGL"
SRC_URI="http://gliv.tuxfamily.org/gliv-${PV}.tar.bz2"
HOMEPAGE="http://gliv.tuxfamily.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2.2 >=x11-libs/gtkglext-0.7.0"

src_compile() {
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc COPYING README NEWS THANKS
}

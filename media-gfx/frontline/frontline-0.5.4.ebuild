# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/frontline/frontline-0.5.4.ebuild,v 1.1 2003/03/13 01:32:51 george Exp $

IUSE=""

DESCRIPTION="Front-End to Autotrace (Converts Bitmaps to vector-grahics)"
SRC_URI="http://ftp1.sourceforge.net/autotrace/${P}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-gfx/autotrace-0.31.1
	>=media-gfx/gimp-1.2.1
	>=media-libs/libart_lgpl-2.3.8
	>=media-libs/imlib-1.8.2"

src_compile() {
	econf
	emake -j 1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

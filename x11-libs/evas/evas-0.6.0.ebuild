# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/evas/evas-0.6.0.ebuild,v 1.11 2003/02/13 16:55:07 vapier Exp $

DESCRIPTION="hardware-accelerated canvas library from the enlightenment project"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.bz2"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="opengl"

DEPEND="x11-base/xfree
	=media-libs/freetype-1*
	media-libs/imlib2
	opengl? ( virtual/opengl )"

src_compile() {
	econf `use_enable opengl gl` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README FAQ-EVAS doc/evas.pdf
}

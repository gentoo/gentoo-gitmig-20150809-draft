# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/flphoto/flphoto-1.3.1.ebuild,v 1.1 2007/09/20 14:05:05 armin76 Exp $

DESCRIPTION="Basic image management and display program based on the FLTK toolkit"
HOMEPAGE="http://www.easysw.com/~mike/flphoto/"
SRC_URI="mirror://sourceforge/fltk/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cups gphoto2"

DEPEND=">=x11-libs/fltk-1.1.4
	cups? ( net-print/cups )
	gphoto2? ( media-gfx/gphoto2 )"

src_compile() {
	econf --with-docdir=/usr/share/doc/${P} || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
}

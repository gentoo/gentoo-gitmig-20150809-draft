# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metisse/metisse-0.3.4.ebuild,v 1.1 2004/12/03 04:12:47 usata Exp $

# fc is broken
IUSE="freetype xv"

DESCRIPTION="Experimental X desktop with some OpenGL capacity."
SRC_URI="http://insitu.lri.fr/~chapuis/software/metisse/${P}.tar.bz2"
HOMEPAGE="http://insitu.lri.fr/~chapuis/metisse"

DEPEND="virtual/x11
	>=x11-libs/nucleo-0.1_p20041130"
RDEPEND="${DEPEND}
	!x11-wm/fvwm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	econf \
		$(use_enable xv) \
		$(use_enable freetype) \
		|| die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

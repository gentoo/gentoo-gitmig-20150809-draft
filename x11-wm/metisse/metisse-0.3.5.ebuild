# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metisse/metisse-0.3.5.ebuild,v 1.1 2005/02/20 10:55:13 usata Exp $

# fc is broken
IUSE="truetype xv opengl"

DESCRIPTION="Experimental X desktop with some OpenGL capacity."
SRC_URI="http://insitu.lri.fr/~chapuis/software/metisse/${P}.tar.bz2"
HOMEPAGE="http://insitu.lri.fr/~chapuis/metisse"

DEPEND="virtual/x11
	>=x11-libs/nucleo-0.1_p20041216
	truetype? ( media-libs/freetype )"
RDEPEND="${DEPEND}
	!x11-wm/fvwm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	local myconf
	if use opengl && use x86 ; then
		myconf="${myconf} --enable-glx-x86"
	elif use opengl ; then
		myconf="${myconf} --enable-glx --disable-glx-x86"
	else
		myconf="${myconf} --disable-glx --disable-glx-x86"
	fi

	econf \
		$(use_enable xv) \
		$(use_enable truetype freetype) \
		${myconf} \
		|| die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

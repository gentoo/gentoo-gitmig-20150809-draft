# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdv/libdv-0.99-r1.ebuild,v 1.1 2003/08/20 14:54:00 liquidx Exp $

IUSE="sdl gtk xv"

DESCRIPTION="software codec for dv-format video (camcorders etc)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libdv.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND=" dev-libs/popt
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk? ( =dev-libs/glib-1.2* )
	xv? ( x11-base/xfree )
	dev-util/pkgconfig
	sdl? ( >=media-libs/libsdl-1.2.4.20020601 )"

MAKEOPTS="-j1"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-disablegtk.patch
}

src_compile() {
	local myconf="--without-debug"
	myconf="${myconf} `use_enable gtk` `use_enable gtk gtktest`"
	myconf="${myconf} `use_enable sdl`"
	myconf="${myconf} `use_enable xv`"

	unset CFLAGS CXXFLAGS

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS COPYING COPYRIGHT ChangeLog INSTALL NEWS README* TODO
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.6.3-r1.ebuild,v 1.1 2003/04/19 11:57:47 mksoft Exp $

IUSE="truetype gtk gnome imlib nls"

S=${WORKDIR}/${P}
DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="BSD"

DEPEND="virtual/x11
	imlib?    ( >=media-libs/imlib-1.9.14 )
	gtk?      ( >=x11-libs/gtk+-1.2.10 )
	gnome?    ( >=media-libs/gdk-pixbuf-0.18.0 )
	truetype? ( >=media-libs/freetype-2.1.2 )
	nls?      ( >=dev-libs/fribidi-0.10.4 )"


src_compile() {
	local myconf

	use imlib \
		&& myconf="${myconf} --enable-imlib"

	use gnome \
		&& myconf="${myconf} --enable-gdk-pixbuf"

	use truetype \
		&& myconf="${myconf} --enable-anti-alias"

	use nls \
		&& myconf="${myconf} --enable-fribidi"

	myconf="${myconf} --enable-utmp"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc ChangeLog LICENCE README
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.5.0-r1.ebuild,v 1.1 2002/09/14 06:46:27 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86"
LICENSE="BSD"

DEPEND="virtual/x11
	imlib?    ( >=media-libs/imlib-1.9.14 )
	gtk?      ( >=x11-libs/gtk+-1.2.10 )
	gnome?    ( >=media-libs/gdk-pixbuf-0.18.0 )
	truetype? ( >=media-libs/freetype-2.1.2 )"


src_compile() {
	local myconf

	use imlib \
		&& myconf="${myconf} --enable-imlib"

	use gnome \
		&& myconf="${myconf} --enable-gdk-pixbuf"

	use truetype \
		&& myconf="${myconf} --enable-anti-alias"

	myconf="${myconf} --enable-utmp"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc ChangeLog LICENCE README
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/playmidi/playmidi-2.5.ebuild,v 1.3 2004/03/31 18:31:59 eradicator Exp $

inherit eutils

DESCRIPTION="Command Line and GUI based MIDI Player"
HOMEPAGE="http://sourceforge.net/projects/playmidi/"
LICENSE="GPL-2"

IUSE="svga X gtk"

DEPEND="sys-libs/ncurses
	svga? ( media-libs/svgalib )
	gtk? ( =dev-libs/glib-1*
		=x11-libs/gtk+-1* )
	X? ( virtual/x11 )"

SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc ~sparc"

S=${WORKDIR}/${P/2.5/2.4}
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

CFLAGS="${CFLAGS} `/usr/bin/gtk-config --cflags`"

src_compile() {
	epatch ${FILESDIR}/${P}.patch

	./Configure < ${FILESDIR}/${P}.conf

	if [ `use gtk` ] ; then
		CFLAGS="${CFLAGS} `/usr/bin/gtk-config --cflags`"
	fi

	make CFLAGS="${CFLAGS}" playmidi || die
	use svga && make CFLAGS="${CFLAGS}" splaymidi || die
	use X && make CFLAGS="${CFLAGS}" xplaymidi || die
	use gtk && make CFLAGS="${CFLAGS}" LIBGTK="`gtk-config --libs`" gtkplaymidi || die
}

src_install() {
	dobin playmidi || die
	use svga && dobin splaymidi || die
	use X && dobin xplaymidi || die
	use gtk && dobin gtkplaymidi || die

	dodoc BUGS COPYING QuickStart README.1ST

	docinto techref
	dodoc techref/*
}

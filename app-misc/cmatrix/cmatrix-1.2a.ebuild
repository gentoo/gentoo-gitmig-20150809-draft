# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cmatrix/cmatrix-1.2a.ebuild,v 1.9 2004/03/30 00:22:22 gustavoz Exp $

DESCRIPTION="An ncurses based app to show a scrolling screen from the Matrix"
HOMEPAGE="http://www.asty.org/cmatrix"
SRC_URI="http://www.asty.org/${PN}/dist/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 sparc"
IUSE="X"

DEPEND="X? ( virtual/x11 )
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}

	# patch Makefile.am to make sure the fonts installations don't violate the
	# sandbox.
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	automake
}

src_compile() {
	econf
	emake || die
}

src_install() {
	dodir /usr/share/consolefonts
	dodir /usr/lib/kbd/consolefonts
	if [ `use X` ] ; then
		dodir /usr/lib/X11/fonts/misc
		dodir /usr/X11R6/lib/X11/fonts/misc
	fi
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	if [ `use X` ] ; then
		if test -d /usr/lib/X11/fonts/misc; then
			einfo ">>> Running mkfontdir on /usr/lib/X11/fonts/misc"
			mkfontdir /usr/lib/X11/fonts/misc
		fi

		if test -d /usr/X11R6/lib/X11/fonts/misc; then
			einfo ">>> Running mkfontdir on /usr/X11R6/lib/X11/fonts/misc"
			mkfontdir /usr/X11R6/lib/X11/fonts/misc
		fi
	fi
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cmatrix/cmatrix-1.2a.ebuild,v 1.10 2004/04/06 04:11:16 vapier Exp $

inherit eutils

DESCRIPTION="An ncurses based app to show a scrolling screen from the Matrix"
HOMEPAGE="http://www.asty.org/cmatrix"
SRC_URI="http://www.asty.org/${PN}/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
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

src_install() {
	dodir /usr/share/consolefonts
	dodir /usr/lib/kbd/consolefonts
	if use X ; then
		dodir /usr/lib/X11/fonts/misc
		dodir /usr/X11R6/lib/X11/fonts/misc
	fi
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	if use X ; then
		if [ -d ${ROOT}/usr/lib/X11/fonts/misc ] ; then
			einfo ">>> Running mkfontdir on ${ROOT}/usr/lib/X11/fonts/misc"
			mkfontdir ${ROOT}/usr/lib/X11/fonts/misc
		fi

		if [ -d ${ROOT}/usr/X11R6/lib/X11/fonts/misc ] ; then
			einfo ">>> Running mkfontdir on ${ROOT}/usr/X11R6/lib/X11/fonts/misc"
			mkfontdir ${ROOT}/usr/X11R6/lib/X11/fonts/misc
		fi
	fi
}

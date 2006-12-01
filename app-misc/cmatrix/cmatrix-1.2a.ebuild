# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cmatrix/cmatrix-1.2a.ebuild,v 1.20 2006/12/01 23:11:41 masterdriverz Exp $

WANT_AUTOMAKE="latest"

inherit eutils autotools

DESCRIPTION="An ncurses based app to show a scrolling screen from the Matrix"
HOMEPAGE="http://www.asty.org/cmatrix.html"
SRC_URI="http://www.asty.org/${PN}/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="X"

DEPEND="X? ( || ( x11-apps/mkfontdir virtual/x11 ) )
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}

	# patch Makefile.am to make sure the fonts installations don't violate the
	# sandbox.
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	eautomake || die 'automake failed'
}

src_install() {
	dodir /usr/share/consolefonts || die 'dodir failed'
	dodir /usr/lib/kbd/consolefonts || die 'dodir failed'
	if use X ; then
		dodir /usr/lib/X11/fonts/misc || die 'dodir failed'
		dodir /usr/X11R6/lib/X11/fonts/misc || die 'dodir failed'
	fi
	emake DESTDIR=${D} install || die 'emake install failed'
}

pkg_postinst() {
	if use X ; then
		if [ -d ${ROOT}/usr/lib/X11/fonts/misc ] ; then
			einfo ">>> Running mkfontdir on ${ROOT}/usr/lib/X11/fonts/misc"
			mkfontdir ${ROOT}/usr/lib/X11/fonts/misc || die 'mkfontdir failed'
		fi

		if [ -d ${ROOT}/usr/X11R6/lib/X11/fonts/misc ] ; then
			einfo ">>> Running mkfontdir on ${ROOT}/usr/X11R6/lib/X11/fonts/misc"
			mkfontdir ${ROOT}/usr/X11R6/lib/X11/fonts/misc || die 'mkfontdir failed'
		fi
	fi
}

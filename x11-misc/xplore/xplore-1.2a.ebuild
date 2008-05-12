# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xplore/xplore-1.2a.ebuild,v 1.11 2008/05/12 08:32:07 nelchael Exp $

inherit eutils

DESCRIPTION="motif file manager for X."
HOMEPAGE="http://www.musikwissenschaft.uni-mainz.de/~ag/xplore/"
SRC_URI="http://www.musikwissenschaft.uni-mainz.de/~ag/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

# its webpage states the lesstif does not fully work with xplore
RDEPEND="x11-libs/openmotif"
DEPEND="${RDEPEND}
	x11-misc/gccmakedep
	app-text/rman
	x11-misc/imake"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-strerror.patch"
	epatch "${FILESDIR}/${P}-malloc.patch"
	epatch "${FILESDIR}/${P}-label.patch"
}

src_compile() {
	#Fix Xplore.tmpl so installation is to /usr instead of /usr/X11R6
	#Note: LIBDIR is used to point to X11 tree.
	cp Xplore.tmpl Xplore.tmpl.orig
	sed -e "s:^\(XPLORELIBDIR = \).*:\1/usr/lib/xplore:" \
		-e "s:^XCOMM \(BINDIR = /usr\)/local\(/bin\):\1\2:" \
		-e "s:^XCOMM \(MANPATH = /usr\)/local\(/man\):\1/share\2:" \
		Xplore.tmpl.orig > Xplore.tmpl

	xmkmf -a || die "xmkmf Makefile creation failed"
	# parallel make fails
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README TODO
}

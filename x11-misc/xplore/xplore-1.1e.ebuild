# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xplore/xplore-1.1e.ebuild,v 1.2 2004/01/13 16:20:47 lanius Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="motif file manager for X."
SRC_URI="http://www.musikwissenschaft.uni-mainz.de/~ag/xplore/${P}.tar.bz2"
HOMEPAGE="http://www.musikwissenschaft.uni-mainz.de/~ag/xplore/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# its webpage states the lesstif does not fully work with xplore
DEPEND="virtual/x11
	x11-libs/openmotif"

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
	make DESTDIR=${D} install || die "Installation failed"
	dodoc COPYING ChangeLog INSTALL README TODO
}

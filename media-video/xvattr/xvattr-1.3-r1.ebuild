# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xvattr/xvattr-1.3-r1.ebuild,v 1.3 2004/03/30 05:10:39 spyderous Exp $

DESCRIPTION="X11 XVideo Querying/Setting Tool from Ogle project"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"
SLOT=0
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="gtk"
DEPEND="virtual/x11
	gtk? ( =x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2* )"
RDEPEND="${DEPEND}"

src_compile() {
	# If no gtk then modify the necessary parts so that gtk isn't needed anymore
	if [ -z `use gtk` ]
	then
	    cd ${S}
	    rm Makefile.in
	    cp Makefile.am Makefile.am.orig
	    sed -e "s/bin_PROGRAMS = xvattr gxvattr/bin_PROGRAMS = xvattr/" -e "s/gxvattr_SOURCES = gxvattr.c//" -e "s/CFLAGS = @GTK_CFLAGS@//" -e "s/gxvattr_LDADD = @GTK_LIBS@ \$(X_LIBS) \$(X_PRE_LIBS) \$(X_EXTRA_LIBS) -lX11 -lXext//" Makefile.am.orig >Makefile.am
	    rm Makefile.am.orig

	    cp configure.in configure.in.orig
	    sed -e "s/dnl check for gtk//" -e "s/AM_PATH_GTK//" configure.in.orig >configure.in
	    rm configure.in.orig
	    automake
	    autoconf
	fi
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}

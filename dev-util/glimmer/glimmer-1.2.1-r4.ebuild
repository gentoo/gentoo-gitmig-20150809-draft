# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glimmer/glimmer-1.2.1-r4.ebuild,v 1.9 2004/07/14 23:35:25 agriffis Exp $

S=${WORKDIR}/glimmer-${P_VERSION}
DESCRIPTION="All-purpose gnome code editor."
SRC_URI="mirror://sourceforge/glimmer/${P}.tar.gz"
HOMEPAGE="http://glimmer.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=gnome-base/gnome-vfs-1*
	>=gnome-base/gnome-libs-1.4.1.7
	>=gnome-base/ORBit-0.5.16
	>=gnome-base/gnome-print-0.35"

# These are requirements when build with --enable-python.
# We should update this to build with --enable-python if USE=python,
# some work might have to be done to make play with Python 2.X

#	>=dev-lang/python-1.5.2
#	>=dev-python/gnome-python-1.4.1"

src_compile() {

#--disable-python disable python scripting, needed to build with python-2.x
# see homepage

	# regex is included in glibc now, so disable buildin regex since it cause compile errors
	cd ${WORKDIR}/${P}
	mv src/gtkextext/gtkextext.h src/gtkextext/gtkextext.h.orig
	sed -e 's/\#include "..\/regex\/regex.h"/\#include <regex.h>/' \
		src/gtkextext/gtkextext.h.orig >src/gtkextext/gtkextext.h
	mv src/Makefile.am src/Makefile.am.orig
	grep -v 'regex/libregex.a \\' src/Makefile.am.orig >src/Makefile.am.grep
	sed -e 's/SUBDIRS \= regex gtkextext/SUBDIRS \= gtkextext/' \
		src/Makefile.am.grep >src/Makefile.am
	automake

	econf \
		--disable-python || die

	cp po/Makefile po/Makefile.orig
	sed -e 's/prefix = \/usr/prefix = \${DESTDIR}\/usr/' po/Makefile.orig \
		> po/Makefile
	make || die
}

src_install () {
	cd ${WORKDIR}/${P}
	make DESTDIR=${D} install || die
	dodoc AUTHORS ABOUT-NLS ChangeLog NEWS PROPS TODO README INSTALL COPYING
}

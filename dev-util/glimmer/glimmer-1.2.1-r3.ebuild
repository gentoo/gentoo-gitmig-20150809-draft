# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/glimmer/glimmer-1.2.1-r3.ebuild,v 1.1 2002/08/13 14:59:43 styx Exp $

S=${WORKDIR}/glimmer-${P_VERSION}
DESCRIPTION="All-purpose gnome code editor."
SRC_URI="mirror://sourceforge/glimmer/${P}.tar.gz"
HOMEPAGE="http://glimmer.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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
	sed -e 's/\#include "..\/regex\/regex.h"/\#include <regex.h>/' src/gtkextext/gtkextext.h.orig >src/gtkextext/gtkextext.h	
	mv src/Makefile.am src/Makefile.am.orig
	grep -v 'regex/libregex.a \\' src/Makefile.am.orig >src/Makefile.am.grep
	sed -e 's/SUBDIRS \= regex gtkextext/SUBDIRS \= gtkextext/' src/Makefile.am.grep >src/Makefile.am
	automake

	econf \
		--disable-python || die
	
	make || die
}

src_install () {
	cd ${WORKDIR}/${P}
	make DESTDIR=${D} install || die
	dodoc AUTHORS ABOUT-NLS ChangeLog NEWS PROPS TODO README INSTALL COPYING
}

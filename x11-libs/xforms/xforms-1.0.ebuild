# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0.ebuild,v 1.4 2003/09/07 00:23:28 msterret Exp $

S=${WORKDIR}/${P}-release
DESCRIPTION="A graphical user interface toolkit for X"
HOMEPAGE="http://world.std.com/~xforms/"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/OpenSource/${P}-release.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/x11"
IUSE=""

PROVIDE="virtual/xforms"

src_unpack() {
	unpack $A
	cd ${WORKDIR}/${P}-release

	# use custom CFLAGS
	cp Imakefile Imakefile.orig
	sed -e "s:CDEBUGFLAGS =:CDEBUGFLAGS = ${CFLAGS} #:" \
		-e "s:CDEBUGFLAGS	=:CDEBUGFLAGS	= ${CFLAGS} #:" Imakefile.orig > Imakefile
}

src_compile() {
	xmkmf -a
	cp Makefile Makefile.orig
	sed -e s/'demos$'// Makefile.orig > Makefile

	# use custom CFLAGS
	cp Makefile Makefile.orig
	sed -e "s:CDEBUGFLAGS =:CDEBUGFLAGS = ${CFLAGS} #:" \
		-e "s:CDEBUGFLAGS	=:CDEBUGFLAGS	= ${CFLAGS} #:" Makefile.orig > Makefile

	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}

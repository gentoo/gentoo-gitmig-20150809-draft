# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Chris Lee <c_lee@mac.com>
# Maintainer: Chris Lee <c_lee@mac.com>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.5 2002/04/29 22:56:53 sandymac Exp

S=${WORKDIR}/${P}
DESCRIPTION="This is a required for GTK+ in GNOME2"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/libiconv/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libiconv/index.html"
LICENSE="LGPL-2.1"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	mv man/Makefile man/Makefile.orig
	sed -e 's/mkdir/$(MKDIR)/' man/Makefile.orig > man/Makefile
	emake || die
}

src_install () {
	make MKDIR="mkdir -p" DESTDIR=${D} install || die
}

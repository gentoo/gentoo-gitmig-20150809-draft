# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# /home/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.3d.ebuild,v 1.1 2001/06/22 04:05:26 tadpol Exp

S=${WORKDIR}/xfig.3.2.3d
DESCRIPTION=""
SRC_URI="http://www.xfig.org/xfigdist/xfig.3.2.3d.full.tar.gz"
HOMEPAGE="http://www.xfig.org/"

DEPEND="virtual/glibc
        >=x11-base/xfree-4.0
        >=media-libs/jpeg-6
        >=media-libs/libpng-1.0.9
        "

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch
	ln -s . Doc/Doc # Fix manual page problem.
}

src_compile() {
	xmkmf || die
	make || die
}

src_install () {
	#Now install it.
	make DESTDIR=${D} install || die
	make DESTDIR=${D} MANDIR=/usr/share/man/man1 MANSUFFIX=1 install.all || die

	#Install docs
	dodoc README FIGAPPS CHANGES LATEX.AND.XFIG
}

# vim: ai et sw=4 ts=4

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xstroke/xstroke-0.5.12-r1.ebuild,v 1.3 2004/04/11 17:48:39 pyrania Exp $

inherit eutils

IUSE=""

DESCRIPTION="Gesture/Handwriting recognition engine for X"
HOMEPAGE="http://dsn.east.isi.edu/xstroke/"
SRC_URI="ftp://ftp.handhelds.org/pub/projects/${PN}/release-0.5/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~mips hppa"

DEPEND=">=x11-base/xfree-4.1.0"

src_unpack() {
	unpack ${A}
	# generate Makefile from Imakefile
	cd ${S}; xmkmf -a
}

src_compile() {
	# otherwise it'll include the wrong freetype headers.
	make \
		INCLUDES="-I/usr/include/freetype2" \
		DEFINES="-DXK_XKB_KEYS" \
		|| die
}

src_install() {
	make DESTDIR=${D} BINDIR=/usr/bin install || die
	newman xstroke.man xstroke.1
	dodoc AUTHORS COPYING ChangeLog README TODO
	dohtml -r doc
}

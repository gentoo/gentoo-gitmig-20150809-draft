# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xstroke/xstroke-0.5.12-r1.ebuild,v 1.7 2004/09/02 22:49:42 pvdabeel Exp $

DESCRIPTION="Gesture/Handwriting recognition engine for X"
HOMEPAGE="http://dsn.east.isi.edu/xstroke/"
SRC_URI="ftp://ftp.handhelds.org/pub/projects/${PN}/release-0.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~mips hppa"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	xmkmf -a # generate Makefile from Imakefile
}

src_compile() {
	# otherwise it'll include the wrong freetype headers.
	emake \
		INCLUDES="-I/usr/include/freetype2" \
		DEFINES="-DXK_XKB_KEYS" \
			|| die "emake failed"
}

src_install() {
	make DESTDIR="${D}" BINDIR=/usr/bin install || die "make install failed"
	newman xstroke.man xstroke.1
	dodoc AUTHORS ChangeLog README TODO
	dohtml -r doc
}

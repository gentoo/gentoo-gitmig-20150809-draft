# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fblogo/fblogo-0.5.0.ebuild,v 1.5 2004/01/26 11:19:37 spock Exp $

DESCRIPTION="Creates images to substitute Linux boot logo"
HOMEPAGE="http://freakzone.net/gordon/#fblogo"
SRC_URI="http://freakzone.net/gordon/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ~sparc"

IUSE=""
DEPEND="media-libs/libpng
	sys-libs/zlib"
RDEPEND="sys-apps/sed"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv -f Makefile Makefile.orig
	sed -e "s:/usr/local:/usr:g" -e "s:^install\:$:install\:\n\
		mkdir -p \${DESTDIR}\${PREFIX}\n\
		mkdir -p \${DESTDIR}\${BINDIR}\n\
		mkdir -p \${DESTDIR}\${MANDIR}/man1:" Makefile.orig > Makefile
	rm -f Makefile.orig
}

src_compile() {
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README CHANGES COPYING
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fblogo/fblogo-0.5.2.ebuild,v 1.3 2004/03/27 19:30:58 spock Exp $

IUSE=""

DESCRIPTION="Creates images to substitute Linux boot logo"
HOMEPAGE="http://freakzone.net/gordon/#fblogo"
SRC_URI="http://freakzone.net/gordon/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND=">=sys-apps/sed-4
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/usr/local:/usr:g" \
		-e "s:^install\:$:install\:\n\
		mkdir -p \${DESTDIR}\${PREFIX}\n\
		mkdir -p \${DESTDIR}\${BINDIR}\n\
		mkdir -p \${DESTDIR}\${MANDIR}/man1:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README CHANGES COPYING
}

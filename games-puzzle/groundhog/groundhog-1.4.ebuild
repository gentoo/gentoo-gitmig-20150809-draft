# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/groundhog/groundhog-1.4.ebuild,v 1.4 2004/02/03 21:29:38 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Kids card/puzzle game"
HOMEPAGE="http://home-2.consunet.nl/~cb007736/groundhog.html"
SRC_URI="http://home-2.consunet.nl/~cb007736/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="virtual/x11
	=x11-libs/gtk+-2*
	=dev-libs/glib-2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	egamesconf `use_enable nls` || die
	emake CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README NEWS AUTHORS TODO Changelog
	prepgamesdirs
}

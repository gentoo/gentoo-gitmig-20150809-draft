# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/lletters/lletters-0.1.95-r1.ebuild,v 1.3 2004/02/13 04:10:17 mr_bones_ Exp $

inherit games

DESCRIPTION="Game that helps young kids learn their letters and numbers"
HOMEPAGE="http://lln.sourceforge.net/"
SRC_URI="mirror://sourceforge/lln/${PN}-media-0.1.9a.tar.gz
	mirror://sourceforge/lln/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11
	media-libs/imlib
	=x11-libs/gtk+-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

IUSE="nls"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	cp -f "${FILESDIR}/tellhow.h.gentoo" tellhow.h || die "cp failed"
	unpack lletters-media-0.1.9a.tar.gz
}

src_compile() {
	egamesconf `use_enable nls` || die
	emake || die "emake failed"

}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog README* TODO || die "dodoc failed"
	prepgamesdirs
}

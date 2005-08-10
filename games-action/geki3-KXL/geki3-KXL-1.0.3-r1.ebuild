# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/geki3-KXL/geki3-KXL-1.0.3-r1.ebuild,v 1.7 2005/08/10 19:18:27 r3pek Exp $

inherit eutils games

DESCRIPTION="2D length scroll shooting game"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=dev-games/KXL-1.1.7"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gentoo-paths.patch
	export WANT_AUTOCONF=2.5
	aclocal && automake -a -c && autoconf || die "autotools failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
	prepgamesdirs
}

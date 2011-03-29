# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gmult/gmult-5.3.ebuild,v 1.5 2011/03/29 07:54:52 angelos Exp $

EAPI=1
inherit eutils gnome2-utils games

DESCRIPTION="Multiplication Puzzle is a simple GTK+ 2 game that emulates the multiplication game found in Emacs"
HOMEPAGE="http://www.mterry.name/gmult/"
SRC_URI="http://www.mterry.name/gmult/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.6:2.4
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e 's/-pedantic//' \
		gmult/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--datadir=/usr/share \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README THANKS
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

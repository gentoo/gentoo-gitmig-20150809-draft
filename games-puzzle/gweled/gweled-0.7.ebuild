# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gweled/gweled-0.7.ebuild,v 1.1 2005/10/04 20:07:44 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="Bejeweled clone game"
HOMEPAGE="http://sebdelestaing.free.fr/gweled/"
SRC_URI="http://sebdelestaing.free.fr/gweled/Release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	media-libs/libmikmod
	>=gnome-base/librsvg-2
	>=gnome-base/libgnomeui-2"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "209d" \
		-e "368 s/swap_sfx/click_sfx/" \
		"${S}/src/main.c" \
		|| die "sed failed"
	sed -i \
		-e "/free (message)/ s/free/g_free/" "${S}/src/graphic_engine.c" \
		|| die "sed failed"
}

src_compile() {
	filter-flags -fomit-frame-pointer
	econf --disable-setgid || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# FIXME: /var/lib is hard-coded.  Need to patch this.
	touch "${D}/var/lib/games/gweled.timed.scores"
	fperms 664 /var/lib/games/gweled.timed.scores
	gamesowners -R "${D}/var/lib/games/"
	dodoc AUTHORS NEWS
	prepgamesdirs
}

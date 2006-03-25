# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/bygfoot/bygfoot-1.9.5.ebuild,v 1.1 2006/03/25 18:08:31 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="GTK+2 Soccer Management Game"
HOMEPAGE="http://bygfoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	sed -i \
		-e '/PACKAGE_LOCALE_DIR/s:\$(prefix)/\$(DATADIRNAME):/usr/share:' \
		"${S}"/src/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e '/localedir/s:\$(libdir):/usr/share:' \
		-e '/gnulocaledir/s:\$(datadir):/usr/share:' \
		"${S}"/po/Makefile.in.in \
		|| die "sed failed"
}

src_install() {
	localedir=/usr/share/locale \
	make DESTDIR="${D}" install || die "make install failed"
	#dogamesbin src/bygfoot b-u/bygfoot-update-gui || die "dobin failed"
	dodoc AUTHORS ChangeLog README TODO UPDATE
	#insinto "${GAMES_DATADIR}/${PN}"
	#doins -r support_files/ || die "game data failed"
	newicon support_files/pixmaps/bygfoot_icon.png ${PN}.png
	make_desktop_entry ${PN} "Bygfoot"
	prepgamesdirs
}

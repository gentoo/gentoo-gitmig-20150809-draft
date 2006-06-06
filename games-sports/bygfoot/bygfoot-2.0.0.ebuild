# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/bygfoot/bygfoot-2.0.0.ebuild,v 1.1 2006/06/06 04:17:54 mr_bones_ Exp $

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
	dodoc AUTHORS ChangeLog README TODO UPDATE
	newicon support_files/pixmaps/bygfoot_icon.png ${PN}.png
	make_desktop_entry ${PN} "Bygfoot"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "If you'd like to keep your settings and savegames from previous"
	einfo "1.9.x versions, you should rename the .bygfoot-1.9 directory"
	einfo "to .bygfoot in your home directory."
	echo
	einfo "If you upgrade from 1.8.x, you should first delete the .bygfoot"
	einfo "directory in your home dir to keep things clean."
	einfo "Also note that savegames from 1.8.x are not compatible with"
	einfo "current versions of ${PN}"
}

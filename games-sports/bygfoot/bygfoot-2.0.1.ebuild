# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/bygfoot/bygfoot-2.0.1.ebuild,v 1.2 2007/01/12 01:19:43 nyhm Exp $

inherit eutils games

DESCRIPTION="GTK+2 Soccer Management Game"
HOMEPAGE="http://bygfoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	virtual/libintl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/PACKAGE_LOCALE_DIR/s:\$(prefix)/\$(DATADIRNAME):/usr/share:' \
		src/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-gstreamer \
		--with-localedir=/usr/share/locale \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO UPDATE
	newicon support_files/pixmaps/bygfoot_icon.png ${PN}.png
	make_desktop_entry ${PN} "Bygfoot"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "If you'd like to keep your settings and savegames from previous"
	elog "1.9.x versions, you should rename the .bygfoot-1.9 directory"
	elog "to .bygfoot in your home directory."
	echo
	elog "If you upgrade from 1.8.x, you should first delete the .bygfoot"
	elog "directory in your home dir to keep things clean."
	elog "Also note that savegames from 1.8.x are not compatible with"
	elog "current versions of ${PN}"
	echo
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/qtads/qtads-2.1.4.ebuild,v 1.1 2012/08/24 17:34:20 hasufell Exp $

EAPI=2
inherit eutils gnome2-utils fdo-mime flag-o-matic qt4-r2 toolchain-funcs games

DESCRIPTION="Multimedia interpreter for TADS text adventures"
HOMEPAGE="http://qtads.sourceforge.net"
SRC_URI="mirror://sourceforge/qtads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[audio]
	media-libs/sdl-mixer[midi,vorbis]
	media-libs/sdl-sound[mp3]
	x11-libs/qt-core
	x11-libs/qt-gui:4"

src_configure() {
	# strict-aliasing should not be used
	# http://bugdb.tads.org/view.php?id=163
	append-cxxflags -fno-strict-aliasing
	append-cflags -fno-strict-aliasing
	qt4-r2_src_configure
}

src_compile() {
	# make build output verbose (yes, weird)
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) LINK=$(tc-getCXX)
}

src_install() {
	dogamesbin qtads || die
	doman qtads.6
	dodoc AUTHORS BUGS HTML_TADS_LICENSE NEWS README
	newicon -s 256 qtads_256x256.png ${PN}.png
	insinto /usr/share/icons
	doins -r "icons/hicolor" || die
	insinto /usr/share/mime/packages
	doins "icons/qtads.xml" || die
	make_desktop_entry qtads QTads qtads Game "MimeType=application/x-tads;application/x-t3vm-image;"
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/frozen-bubble/frozen-bubble-2.2.0.ebuild,v 1.14 2012/02/21 15:25:50 jer Exp $

EAPI=2
inherit eutils gnome2-utils perl-module games

DESCRIPTION="A Puzzle Bubble clone written in perl (now with network support)"
HOMEPAGE="http://www.frozen-bubble.org/"
SRC_URI="http://www.frozen-bubble.org/data/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# there seems to be color issues on big endian hosts
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=media-libs/sdl-mixer-1.2.3[mikmod,vorbis]
	media-libs/sdl-pango
	media-libs/sdl-image[gif,png]
	dev-perl/SDL
	dev-perl/Locale-gettext"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_prepare() {
	sed -i \
		-e '/^PREFIX /s:=.*:=/usr:' \
		-e "/^BINDIR /s:=.*:=${GAMES_BINDIR}:" \
		-e "/^DATADIR /s:=.*:=${GAMES_DATADIR}:" \
		-e "/^LIBDIR /s:=.*:=$(games_get_libdir):" \
		-e '/^LOCALEDIR /s:=.*:=/usr/share/locale:' \
		-e "/^MANDIR /s:=.*:=/usr/share/man:" \
		settings.mk || die "sed failed"
}

src_install() {
	local res

	emake DESTDIR="${D}" INSTALLDIRS=vendor install || die "make install failed"
	dodoc AUTHORS NEWS README TIPS
	for res in 16x16 32x32 48x48 64x64 ; do
		insinto /usr/share/icons/hicolor/${res}/apps
		newins icons/frozen-bubble-icon-${res}.png ${PN}.png
	done
	make_desktop_entry ${PN} Frozen-Bubble

	fixlocalpod
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

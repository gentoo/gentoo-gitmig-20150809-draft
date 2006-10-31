# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/frozen-bubble/frozen-bubble-2.0.0.ebuild,v 1.5 2006/10/31 02:34:35 vapier Exp $

inherit eutils multilib perl-module games

DESCRIPTION="A Puzzle Bubble clone written in perl (now with network support)"
HOMEPAGE="http://www.frozen-bubble.org/"
SRC_URI="http://www.frozen-bubble.org/data/${P}.tar.bz2
	mirror://gentoo/${P}-colourblind-mini-balls.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=media-libs/sdl-mixer-1.2.3
	media-libs/sdl-pango
	dev-perl/sdl-perl
	dev-perl/Locale-gettext"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

pkg_setup() {
	if ! built_with_use -a media-libs/sdl-image gif png ; then
		ewarn "Frozen-bubble uses GIF and PNG image files."
		ewarn "You must emerge media-libs/sdl-image with GIF and PNG support."
		ewarn "Please USE=\"gif png\" emerge media-libs/sdl-image"
		die "Cannot emerge without gif and png USE flags on sdl-image"
	fi
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		ewarn "You must emerge media-libs/sdl-mixer with mikmod support."
		ewarn "    USE=mikmod emerge media-libs/sdl-mixer"
		die "missing mikmod USE flag for sdl-mixer"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch

	sed -i \
		-e 's:INSTALLDIRS=.*:PREFIX=$(DESTDIR)/usr:' \
		c_stuff/Makefile \
		|| die 'sed failed'
	sed -i \
		-e '/^PREFIX /s:=.*:=/usr:' \
		-e "/^BINDIR /s:=.*:=${GAMES_BINDIR}:" \
		-e "/^DATADIR /s:=.*:=${GAMES_DATADIR}:" \
		-e "/^LIBDIR /s:=.*:=${GAMES_LIBDIR}:" \
		-e '/^LOCALEDIR /s:=.*:=/usr/share/locale:' \
		-e "/^MANDIR /s:=.*:=/usr/share/man:" \
		Makefile po/Makefile server/Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dosed /usr/games/bin/frozen-bubble
	dodoc AUTHORS NEWS README TIPS
	newicon icons/frozen-bubble-icon-48x48.png ${PN}.png
	make_desktop_entry ${PN} ${PN} ${PN}.png

	fixlocalpod
	prepgamesdirs
}

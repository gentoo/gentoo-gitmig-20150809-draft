# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/wordwarvi/wordwarvi-0.25.ebuild,v 1.1 2009/01/19 16:22:47 mr_bones_ Exp $

EAPI=1
inherit eutils games

DESCRIPTION="A retro side-scrolling shoot'em up based on the editor war story"
HOMEPAGE="http://wordwarvi.sourceforge.net"
SRC_URI="mirror://sourceforge/wordwarvi/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-2.0 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vorbis"

RDEPEND="x11-libs/gtk+:2
	vorbis? ( media-libs/libvorbis
		>=media-libs/portaudio-19_pre1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^DATADIR/s/=/?=/' \
		-e '/^OPTIMIZE_FLAG/s/=.*/=$(CFLAGS)/' \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake \
		PREFIX="${GAMES_PREFIX}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		MANDIR="/usr/share/man" \
		WITHAUDIO=$(use vorbis && echo yes || echo no) all \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="${GAMES_PREFIX}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		MANDIR="/usr/share/man" \
		WITHAUDIO=$(use vorbis && echo yes || echo no) all \
		install || die "emake install failed"
	use vorbis || rm -rf "${D}${GAMES_DATADIR}/${PN}"
	dodoc README AUTHORS changelog.txt AAA_HOW_TO_MAKE_NEW_LEVELS.txt
	newicon icons/wordwarvi_icon_128x128.png ${PN}.png
	make_desktop_entry ${PN} "Word War vi"
	prepgamesdirs
}

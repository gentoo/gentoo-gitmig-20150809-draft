# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.6.5.ebuild,v 1.2 2006/09/29 15:35:49 nyhm Exp $

inherit games

DESCRIPTION="An advanced NES, GB/GBC/GBA, TurboGrafx 16/CD, and Lynx emulator"
HOMEPAGE="http://mednafen.com/"
SRC_URI="http://mednafen.com/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="virtual/opengl
	media-libs/libsndfile
	dev-libs/libcdio
	>=media-libs/libsdl-1.2.0
	media-libs/sdl-net
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:\$(datadir)/locale:/usr/share/locale:' \
		$(find . -name 'Makefile.in*') \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		$(use_enable nls) \
		--disable-dependency-tracking || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
	dohtml Documentation/*
	prepgamesdirs
}

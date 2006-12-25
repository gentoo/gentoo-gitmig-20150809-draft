# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.7.1.ebuild,v 1.2 2006/12/25 17:42:29 nyhm Exp $

inherit games

DESCRIPTION="An advanced NES, GB/GBC/GBA, TurboGrafx 16/CD, NGPC and Lynx emulator"
HOMEPAGE="http://mednafen.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa cjk debug nls"

RDEPEND="virtual/opengl
	media-libs/libsndfile
	dev-libs/libcdio
	media-libs/libsdl
	media-libs/sdl-net
	alsa? ( media-libs/alsa-lib )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:$(datadir)/locale:/usr/share/locale:' \
		-e 's:$(localedir):/usr/share/locale:' \
		$(find . -name 'Makefile.in*') \
		|| die "sed Makefile.in failed"
	sed -i '/-fomit-frame/d' configure \
		|| die "sed configure failed"
}

src_compile() {
	# Doesn't like --disable-jack
	#	$(use_enable jack)
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable alsa) \
		$(use_enable cjk cjk-fonts) \
		$(use_enable debug debugger) \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Documentation/cheats.txt AUTHORS ChangeLog TODO
	dohtml Documentation/*
	prepgamesdirs
}

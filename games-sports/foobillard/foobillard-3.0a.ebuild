# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/foobillard/foobillard-3.0a.ebuild,v 1.12 2008/12/07 11:28:02 mr_bones_ Exp $

inherit eutils autotools games

DESCRIPTION="8ball, 9ball, snooker and carambol game"
HOMEPAGE="http://foobillard.sunsite.dk/"
SRC_URI="http://foobillard.sunsite.dk/dnl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="sdl"

RDEPEND="x11-libs/libXaw
	x11-libs/libXi
	virtual/opengl
	virtual/glu
	>=media-libs/freetype-2.0.9
	media-libs/libpng
	sdl? ( media-libs/libsdl )
	!sdl? ( virtual/glut )"
DEPEND="${RDEPEND}
	app-admin/eselect-opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-no_nvidia.patch \
		"${FILESDIR}"/${P}-fbsd.patch \
		"${FILESDIR}"/${P}-as-needed.patch

	eautoreconf
}

src_compile() {
	local myconf
	[[ "$(eselect opengl show)" == 'nvidia' ]] \
		&& myconf='--enable-nvidia=yes' \
		|| myconf='--enable-nvidia=no'

	egamesconf \
		--enable-sound \
		$(use_enable sdl SDL) \
		$(use_enable !sdl glut) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README README.FONTS
	doman foobillard.6
	newicon data/full_symbol.png foobillard.png
	make_desktop_entry foobillard Foobillard
	prepgamesdirs
}

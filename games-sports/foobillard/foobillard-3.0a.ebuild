# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/foobillard/foobillard-3.0a.ebuild,v 1.6 2005/01/05 02:48:21 vapier Exp $

inherit eutils games

DESCRIPTION="8ball, 9ball, snooker and carambol game"
HOMEPAGE="http://foobillard.sunsite.dk/"
SRC_URI="http://foobillard.sunsite.dk/dnl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="sdl"

DEPEND="virtual/x11
	virtual/opengl
	>=media-libs/freetype-2.0.9
	>=media-libs/libpng-1.2.1
	|| (
		sdl? ( media-libs/libsdl )
		(
			virtual/glu
			virtual/glut )
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no_nvidia.patch
}

src_compile() {
	local myconf=""
	[ "$(ls /usr/include/GL/gl.h -al | awk '{print $NF}' | cut -d/ -f5)" == "nvidia" ] \
		&& myconf="--enable-nvidia=yes" \
		|| myconf="--enable-nvidia=no"

	egamesconf \
		--enable-sound \
		$(use_enable sdl SDL) \
		$(use_enable !sdl glut) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README README.FONTS
	doman foobillard.6

	insinto /usr/share/pixmaps
	newins data/full_symbol.png foobillard.png
	make_desktop_entry foobillard Foobillard foobillard.png

	prepgamesdirs
}

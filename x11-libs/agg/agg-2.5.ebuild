# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/agg/agg-2.5.ebuild,v 1.9 2008/06/14 16:00:15 jer Exp $

inherit eutils autotools

DESCRIPTION="Anti-Grain Geometry - A High Quality Rendering Engine for C++"
HOMEPAGE="http://antigrain.com/"
SRC_URI="http://antigrain.com/${P}.tar.gz"
LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="sdl truetype X"

RDEPEND="sdl? ( >=media-libs/libsdl-1.2.0 )
	X? ( x11-libs/libX11 )
	truetype? ( >=media-libs/freetype-2 )"
	# sdl.m4 missing in the tarball
DEPEND="media-libs/libsdl
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	eautoreconf
}

src_compile() {
	# examples are not (yet) installed, so do not compile them
	econf \
		--enable-ctrl \
		--enable-gpc \
		--disable-examples \
		$(use_enable sdl sdltest) \
		$(use_enable truetype freetype) \
		$(use_with X x) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc readme authors ChangeLog news
}

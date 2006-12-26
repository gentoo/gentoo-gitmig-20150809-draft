# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/agg/agg-2.5.ebuild,v 1.5 2006/12/26 12:56:18 drizzt Exp $

WANT_AUTOCONF="1.10"
inherit eutils autotools

DESCRIPTION="Anti-Grain Geometry - A High Quality Rendering Engine for C++"
HOMEPAGE="http://antigrain.com/"
SRC_URI="http://antigrain.com/${P}.tar.gz"
LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="sdl truetype X"

DEPEND="sdl? ( >=media-libs/libsdl-1.2.0 )
	X? ( x11-libs/libX11 )
	truetype? ( >=media-libs/freetype-2 )"

src_compile() {
	eautoreconf || die "eautoreconf failed"
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

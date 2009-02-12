# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/vamos/vamos-0.6.0.ebuild,v 1.3 2009/02/12 20:38:59 tupone Exp $

EAPI=2
inherit eutils

DESCRIPTION="an automotive simulation framework"
HOMEPAGE="http://vamos.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	virtual/glut
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/openal
	media-libs/freealut
	dev-libs/libsigc++:1.2"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc43.patch" \
		"${FILESDIR}"/${P}-as-needed.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-unit-tests \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin caelum/.libs/caelum || die "dobin failed"
	newdoc caelum/README README.caelum
	dodoc AUTHORS ChangeLog README TODO
}

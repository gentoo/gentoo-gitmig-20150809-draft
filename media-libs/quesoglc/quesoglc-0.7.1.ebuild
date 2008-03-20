# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quesoglc/quesoglc-0.7.1.ebuild,v 1.2 2008/03/20 19:49:20 nyhm Exp $

DESCRIPTION="A free implementation of the OpenGL Character Renderer (GLC)"
HOMEPAGE="http://quesoglc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-free.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/fontconfig
	>=media-libs/freetype-2
	dev-libs/fribidi"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf src/fribidi
}

src_compile() {
	# Uses its own copy of media-libs/glew with GLEW_MX
	econf \
		--disable-dependency-tracking \
		--disable-executables \
		--with-fribidi \
		--without-glew \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README THANKS
}

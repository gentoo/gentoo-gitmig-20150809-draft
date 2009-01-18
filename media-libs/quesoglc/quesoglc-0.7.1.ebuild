# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quesoglc/quesoglc-0.7.1.ebuild,v 1.8 2009/01/18 18:41:35 klausman Exp $

DESCRIPTION="A free implementation of the OpenGL Character Renderer (GLC)"
HOMEPAGE="http://quesoglc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-free.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="doc examples"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/fontconfig
	>=media-libs/freetype-2
	dev-libs/fribidi"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

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
	if use doc ; then
		cd docs
		doxygen -u Doxyfile && doxygen || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README THANKS
	if use doc ; then
		dohtml docs/html/* || die "dohtml failed"
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c || die "doins failed"
	fi
}

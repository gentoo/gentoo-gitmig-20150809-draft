# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cegui/cegui-0.6.1.ebuild,v 1.1 2008/06/29 21:01:42 nyhm Exp $

MY_P=CEGUI-${PV}
DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"
SRC_URI="mirror://sourceforge/crayzedsgui/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/crayzedsgui/${MY_P}-DOCS.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug devil doc examples expat irrlicht lua opengl xerces-c xml"

RDEPEND="dev-libs/libpcre
	=media-libs/freetype-2*
	devil? ( media-libs/devil )
	expat? ( dev-libs/expat )
	irrlicht? ( dev-games/irrlicht )
	lua? (
		dev-lang/lua
		dev-lang/toluapp
	)
	opengl? (
		virtual/opengl
		virtual/glu
		virtual/glut
		media-libs/glew
	)
	xerces-c? ( dev-libs/xerces-c )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use examples ; then
		cp -r Samples Samples.clean
		rm -f $(find Samples.clean -name 'Makefile*')
		rm -rf Samples.clean/bin
	fi
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable devil) \
		$(use_enable examples samples) \
		$(use_enable expat) \
		$(use_enable irrlicht irrlicht-renderer) \
		$(use_enable lua external-toluapp) \
		$(use_enable lua lua-module) \
		$(use_enable lua toluacegui) \
		$(use_enable opengl external-glew) \
		$(use_enable opengl opengl-renderer) \
		$(use_enable xerces-c) \
		$(use_enable xml libxml) \
		--enable-static \
		--enable-tga \
		--enable-tinyxml \
		--disable-corona \
		--disable-dependency-tracking \
		--disable-external-tinyxml \
		--disable-freeimage \
		--disable-samples \
		--disable-silly \
		--without-gtk2 \
		--without-ogre-renderer \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	if use doc ; then
		dohtml -r documentation/api_reference || die "dohtml failed"
		dodoc documentation/*.pdf || die "dodoc failed"
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples.clean/* || die "doins failed"
	fi
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cegui/cegui-0.7.6-r1.ebuild,v 1.3 2012/05/20 15:33:05 ago Exp $

EAPI="4"

MY_P=CEGUI-${PV}
MY_D=CEGUI-DOCS-${PV}
DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"
SRC_URI="mirror://sourceforge/crayzedsgui/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/crayzedsgui/${MY_D}.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 -ppc ~x86"
IUSE="bidi debug devil doc examples expat gtk irrlicht lua ogre opengl pcre static-libs tinyxml truetype xerces-c xml zip"
REQUIRED_USE="|| ( expat tinyxml xerces-c xml )" # bug 362223

RDEPEND="bidi? ( dev-libs/fribidi )
	devil? ( media-libs/devil )
	expat? ( dev-libs/expat )
	truetype? ( media-libs/freetype:2 )
	irrlicht? ( dev-games/irrlicht )
	lua? (
		dev-lang/lua
		dev-lua/toluapp
	)
	ogre? ( >=dev-games/ogre-1.7 )
	opengl? (
		virtual/opengl
		virtual/glu
		media-libs/freeglut
		media-libs/glew
	)
	pcre? ( dev-libs/libpcre )
	tinyxml? ( dev-libs/tinyxml )
	xerces-c? ( dev-libs/xerces-c )
	xml? ( dev-libs/libxml2 )
	zip? ( sys-libs/zlib[minizip] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# use minizip from zlib rather than local code
	if use zip ; then
		sed -i \
			-e '/CEGUI_BUILD_MINIZIP_RESOURCE_PROVIDER_TRUE/{
					s:minizip/ioapi.cpp minizip/unzip.cpp::;
					s:libCEGUIBase@cegui_bsfx@_la-ioapi.lo::;
					s:libCEGUIBase@cegui_bsfx@_la-unzip.lo::
				}' \
			-e '/^ZLIB_LIBS/s:=.*:= -lminizip:' \
			cegui/src/Makefile.in || die
	fi
	rm -rf cegui/src/minizip

	if use examples ; then
		cp -r Samples Samples.clean
		rm -f $(find Samples.clean -name 'Makefile*')
	fi
}

src_configure() {
	econf \
		$(use_enable bidi bidirectional-text) \
		$(use_enable debug) \
		$(use_enable devil) \
		$(use_enable examples samples) \
		$(use_enable expat) \
		$(use_enable truetype freetype) \
		$(use_enable irrlicht irrlicht-renderer) \
		$(use_enable lua lua-module) \
		$(use_enable lua toluacegui) \
		--enable-external-toluapp \
		$(use_enable ogre ogre-renderer) \
		$(use_enable opengl opengl-renderer) \
		--enable-external-glew \
		$(use_enable pcre) \
		$(use_enable tinyxml) \
		--enable-external-tinyxml \
		$(use_enable xerces-c) \
		$(use_enable xml libxml) \
		$(use_enable zip minizip-resource-provider) \
		--enable-null-renderer \
		--enable-stb \
		--enable-tga \
		--disable-corona \
		--disable-dependency-tracking \
		--disable-freeimage \
		--disable-rapidxml \
		--disable-samples \
		--disable-silly \
		$(use_with gtk gtk2) \
		$(use_enable static-libs static) \
		--enable-shared
}

src_install() {
	default

	# remove .la files
	use static-libs || rm -f "${D}"/usr/*/*.la

	if use doc ; then
		emake html || die
		dohtml -r doc/doxygen/html/* || die
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples.clean/* || die
	fi
}

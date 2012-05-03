# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cegui/cegui-0.7.5-r1.ebuild,v 1.7 2012/05/03 06:35:30 jdhore Exp $

EAPI=4
inherit eutils

MY_P=CEGUI-${PV}
MY_D=CEGUI-DOCS-${PV}
DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"
SRC_URI="mirror://sourceforge/crayzedsgui/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/crayzedsgui/${MY_D}.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 -ppc x86"
IUSE="bidi debug devil doc examples expat gtk irrlicht lua opengl pcre static-libs tinyxml truetype xerces-c xml zip"
REQUIRED_USE="|| ( xml tinyxml )" # bug 362223

RDEPEND="bidi? ( dev-libs/fribidi )
	devil? ( media-libs/devil )
	expat? ( dev-libs/expat )
	truetype? ( media-libs/freetype:2 )
	irrlicht? ( dev-games/irrlicht )
	lua? (
		dev-lang/lua
		dev-lua/toluapp
	)
	opengl? (
		virtual/opengl
		virtual/glu
		media-libs/freeglut
		media-libs/glew
	)
	pcre? ( dev-libs/libpcre )
	tinyxml? ( dev-libs/tinyxml )
	xerces-c? ( dev-libs/xerces-c )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-tinyxml.patch \
		"${FILESDIR}"/${P}-gcc46.patch

	# build with newer zlib (bug #389863)
	sed -i -e '74i#define OF(x) x' cegui/src/minizip/unzip.h || die
	sed -i -e '125i#define OF(x) x' cegui/src/minizip/ioapi.h || die
	if use examples ; then
		cp -r Samples Samples.clean
		rm -f $(find Samples.clean -name 'Makefile*')
	fi
}

src_configure() {
	# ogre-1.6.5 needs older cegui (bug #387103)
	econf \
		--disable-ogre-renderer \
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
		$(use_enable opengl opengl-renderer) \
		--enable-external-glew \
		$(use_enable pcre) \
		$(use_enable tinyxml) \
		--enable-external-tinyxml \
		$(use_enable xerces-c) \
		$(use_enable xml libxml) \
		$(use_enable zip minizip-resource-provider) \
		--enable-null-renderer \
		--enable-tga \
		--disable-corona \
		--disable-dependency-tracking \
		--disable-samples \
		--disable-silly \
		$(use_with gtk gtk2) \
		$(use_enable static-libs static) \
		--enable-shared
}

src_install() {
	emake DESTDIR="${D}" install || die

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

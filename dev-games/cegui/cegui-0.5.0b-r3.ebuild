# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cegui/cegui-0.5.0b-r3.ebuild,v 1.1 2007/08/11 13:24:28 nyhm Exp $

inherit autotools eutils

MY_P=CEGUI-${PV}
DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"
SRC_URI="mirror://sourceforge/crayzedsgui/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="devil doc examples expat lua opengl xerces-c xml"

RDEPEND="dev-libs/libpcre
	=media-libs/freetype-2*
	devil? ( media-libs/devil )
	expat? ( dev-libs/expat )
	lua? ( dev-lang/lua )
	opengl? ( virtual/opengl
		virtual/glu
		virtual/glut )
	xerces-c? ( dev-libs/xerces-c )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P/b}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use examples ; then
		cp -r Samples Samples.clean
		rm -f $(find Samples.clean -name 'Makefile*')
		rm -rf Samples.clean/bin
	fi
	epatch "${FILESDIR}"/${P}-lua.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable devil) \
		$(use_enable examples samples) \
		$(use_enable expat) \
		$(use_enable lua lua-module) \
		$(use_enable lua toluacegui) \
		$(use_enable opengl opengl-renderer) \
		$(use_enable xerces-c) \
		$(use_enable xml libxml) \
		--enable-static \
		--enable-tga \
		--enable-tinyxml \
		--disable-corona \
		--disable-dependency-tracking \
		--disable-freeimage \
		--disable-irrlicht-renderer \
		--disable-samples \
		--disable-silly \
		--without-gtk2 \
		--without-ogre-renderer \
		|| die
	emake || die "emake failed"
	if use doc ; then
		mkdir -p documentation/api_reference
		doxygen || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	use doc && dohtml -r documentation/api_reference
	if use examples ; then
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples.clean/* || die "doins failed"
	fi
}

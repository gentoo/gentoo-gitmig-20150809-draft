# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-1.4.3-r1.ebuild,v 1.1 2007/08/11 13:23:41 nyhm Exp $

inherit eutils autotools

DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://www.ogre3d.org/"
SRC_URI="mirror://sourceforge/ogre/ogre-linux_osx-v${PV//./-}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc cegui cg devil double-precision examples gtk openexr threads"
RESTRICT="test" #139905

RDEPEND="dev-libs/zziplib
	>=media-libs/freetype-2.1.10
	virtual/opengl
	virtual/glu
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXrandr
	x11-libs/libX11
	cegui? ( >=dev-games/cegui-0.5 )
	cg? ( media-gfx/nvidia-cg-toolkit )
	devil? ( media-libs/devil )
	gtk? (
		>=dev-cpp/gtkmm-2.4
		>=dev-cpp/libglademm-2.4
	)
	openexr? ( >=media-libs/openexr-1.2 )
	threads? ( dev-libs/boost )"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	dev-util/pkgconfig"

S=${WORKDIR}/ogrenew

pkg_setup() {
	if use threads && has_version "<dev-libs/boost-1.34" && \
		! built_with_use dev-libs/boost threads
	then
		die "Please emerge dev-libs/boost with USE=threads"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	find -name CVS -print0 | xargs -0 rm -rf
	if use examples ; then
		cp -r Samples install-examples || die
		find install-examples \
			'(' -name 'Makefile*' -o -name obj -o \
			    -name bin -o -name '*.cbp' -o -name '*.vcproj*' ')' \
			-print0 | xargs -0 rm -rf
	fi
	sed -i '/CPPUNIT/d' configure.in || die "sed failed"
	epatch "${FILESDIR}"/${P}-cegui.patch
	eautoreconf
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-freeimage \
		--disable-ogre-demos \
		--enable-static \
		--with-platform=GLX \
		--with-gui=$(usev gtk || echo Xt) \
		$(use_enable cegui) \
		$(use_enable cg) \
		$(use_enable devil) \
		$(use_enable double-precision double) \
		$(use_enable openexr) \
		$(use_enable threads threading) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use doc ; then
		insinto /usr/share/doc/${PF}/html
		doins -r Docs/* || die "doins Docs failed"
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/Samples
		doins -r install-examples/* || die "doins Samples failed"
	fi
	dodoc AUTHORS BUGS LINUX.DEV README
}

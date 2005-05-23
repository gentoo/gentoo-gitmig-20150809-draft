# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-1.0.1.ebuild,v 1.5 2005/05/23 23:36:10 vapier Exp $

inherit eutils libtool

DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://www.ogre3d.org/"
SRC_URI="mirror://sourceforge/ogre/${PN}-linux_osx-v${PV//./-}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="cegui cg devil double-precision doc gtk opengl openexr sdl threads"

RDEPEND=">=dev-libs/zziplib-0.13.36
	=media-libs/freetype-2*
	threads? ( dev-libs/boost )
	cegui? ( >=dev-games/cegui-0.2.0 )
	devil? ( >=media-libs/devil-1.5 )
	openexr? ( >=media-libs/openexr-1.2 )
	sdl? ( >=media-libs/libsdl-1.2.6 )
	!sdl? ( !opengl? (
		=dev-cpp/gtkglextmm-1.0*
		=dev-cpp/libglademm-2.2*
	) )
	gtk? (
		=dev-cpp/libglademm-2.2*
		=dev-cpp/gtkmm-2.2*
	)
	virtual/opengl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-devel/flex
	cg? ( >=media-gfx/nvidia-cg-toolkit-1.2 )"

S=${WORKDIR}/ogrenew

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	sed -i 's:libtoolize:libtoolize --copy:' bootstrap
	./bootstrap || die "bootstrap failed"
}

src_compile() {
	# For the config toolkit:
	#  USE="gtk" -> gtk
	#  USE="-gtk" -> cli
	local mycfgtk="cli"
	use gtk && mycfgtk="gtk"

	# For the renderer/platform manager:
	#  USE="sdl" -> SDL
	#  USE="-sdl opengl" -> GLX
	#  USE="-sdl -opengl" -> gtk
	local myplat=""
	if use sdl ; then
		myplat="SDL"
	elif use opengl ; then
		myplat="GLX"
	else
		myplat="gtk"
	fi

	econf \
		--with-cfgtk=${mycfgtk} \
		--with-platform=${myplat} \
		--with-gl-support=${myplat} \
		$(use_enable devil) \
		$(use_enable cg) \
		$(use_enable openexr) \
		$(use_enable threads threading) \
		$(use_enable double-precision double) \
		$(use_enable sdl sdltest) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto /usr/share/OGRE/Media
	doins Samples/Media/*
	if use doc ; then
		dohtml -r Docs/* Docs/Tutorials/*
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples/*
	fi
	dodoc AUTHORS BUGS LINUX.DEV README Docs/README.linux
	dohtml Docs/*.html
}

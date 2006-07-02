# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-1.2.1.ebuild,v 1.2 2006/07/02 05:29:48 vapier Exp $

inherit eutils

MY_PV=${PV//./-}
MY_PV=${MY_PV/_/}
DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://www.ogre3d.org/"
SRC_URI="mirror://sourceforge/ogre/${PN}-linux_osx-v${MY_PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="cegui cg devil double-precision examples openexr sdl threads"

RDEPEND=">=dev-libs/zziplib-0.13.36
	>=media-libs/freetype-2.1.10
	threads? ( >=dev-libs/boost-1.33.0 )
	cegui? ( >=dev-games/cegui-0.4.0 )
	devil?	( >=media-libs/devil-1.6.7 )
	openexr? ( >=media-libs/openexr-1.2 )
	sdl? ( >=media-libs/libsdl-1.2.8 )
	virtual/opengl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	cg? ( >=media-gfx/nvidia-cg-toolkit-1.2 )"

S=${WORKDIR}/ogrenew

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autoconf.patch
	./bootstrap || die "bootstrap failed"
}

src_compile() {
	# For the config toolkit:
	local mycfgtk="cli"

	# For the renderer/platform manager:
	local myplat="GLX"
	use sdl && myplat="SDL"

	econf \
		--with-cfgtk=${mycfgtk} \
		--with-platform=${myplat} \
		$(use_enable devil) \
		$(use_enable cg) \
		$(use_enable openexr) \
		$(use_enable threads threading) \
		$(use_enable double-precision double) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	insinto /usr/share/OGRE/Media
	doins Samples/Media/*
	if use examples ; then
		dohtml -r Docs/* Docs/Tutorials/*
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples/*
	fi
	dodoc AUTHORS BUGS LINUX.DEV README Docs/README.linux
	dohtml Docs/*.html
}

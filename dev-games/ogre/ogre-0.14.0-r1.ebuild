# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-0.14.0-r1.ebuild,v 1.2 2005/01/01 18:02:38 eradicator Exp $

inherit eutils

DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://www.ogre3d.org/"
SRC_URI="mirror://sourceforge/ogre/${PN}-linux_osx-v${PV//./-}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE="doc gtk"

RDEPEND="virtual/opengl
	media-libs/libsdl
	=media-libs/freetype-2*
	media-libs/devil
	gtk? (
		=dev-cpp/libglademm-2.0*
		=dev-cpp/gtkmm-2* )
	sys-libs/zlib"
DEPEND="${RDEPEND}
	x86? ( >=media-gfx/nvidia-cg-toolkit-1.2 )
	amd64? ( >=media-gfx/nvidia-cg-toolkit-1.2 )
	>=sys-apps/sed-4
	|| (
		dev-libs/STLport
		>=sys-devel/gcc-3.0 )"

S="${WORKDIR}/ogrenew"

src_unpack() {
	unpack ${A}
	cd ${S}
	case "${ARCH}" in
	x86 | amd64)
		;;
	*)
		einfo "Removing nVidia Cg dependency on this arch"
		epatch "${FILESDIR}/${PV}-nocg.patch"
		rm -rf ${S}/autom4te.cache
		./bootstrap
		;;
	esac
}

src_compile() {
	local myconf="cli"

	use gtk && myconf="gtk"

	econf --with-cfgtk=${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	if use doc ; then
		dohtml -r Docs/* Docs/Tutorials/*
	fi
	insinto /usr/share/OGRE/Media
	doins Samples/Media/*
	dodoc AUTHORS BUGS LINUX.DEV README Docs/README.linux
	dohtml Docs/*.html
}

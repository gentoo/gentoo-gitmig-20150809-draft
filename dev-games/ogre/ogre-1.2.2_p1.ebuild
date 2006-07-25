# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-1.2.2_p1.ebuild,v 1.1 2006/07/25 02:01:47 mr_bones_ Exp $

inherit eutils

MY_PV=${PV//./-}
MY_PV=${MY_PV/_/}
DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://www.ogre3d.org/"
SRC_URI="mirror://sourceforge/ogre/${PN}-linux_osx-v${MY_PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="cegui cg devil double-precision examples gtk openexr threads"

RDEPEND=">=dev-libs/zziplib-0.13.36
	>=media-libs/freetype-2.1.10
	threads? ( >=dev-libs/boost-1.33.0 )
	cegui? ( >=dev-games/cegui-0.4.0 )
	devil? ( >=media-libs/devil-1.6.7 )
	openexr? ( >=media-libs/openexr-1.2 )
	gtk? ( >=dev-cpp/gtkmm-2.4 >=dev-cpp/libglademm-2.4 )
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
	./bootstrap || die "bootstrap failed"

	if use examples ; then
		cp -r Samples install-examples || die
		find install-examples \
			'(' -name 'Makefile*' -o -name CVS -o -name obj -o \
			    -name bin -o -name '*.cbp' -o -name '*.vcproj*' ')' \
			-print0 | xargs -0 rm -rf
	fi
}

src_compile() {
	# For the config toolkit:
	local mycfgtk="cli"
	use gtk && mycfgtk="gtk"

	econf \
		--with-cfgtk=${mycfgtk} \
		--with-platform=GLX \
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
	doins -r Samples/Media/*
	if use examples ; then
		dohtml -r Docs/* Docs/Tutorials/*
		insinto /usr/share/doc/${PF}/Samples
		doins -r install-examples/*
	fi
	dodoc AUTHORS BUGS LINUX.DEV README Docs/README.linux
	dohtml Docs/*.html
}

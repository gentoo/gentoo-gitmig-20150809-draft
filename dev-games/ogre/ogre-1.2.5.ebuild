# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-1.2.5.ebuild,v 1.2 2007/02/14 20:13:24 mr_bones_ Exp $

inherit eutils autotools

MY_PV=${PV//./-}
MY_PV=${MY_PV/_/}
DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://www.ogre3d.org/"
SRC_URI="mirror://sourceforge/ogre/${PN}-linux_osx-v${MY_PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="cegui cg devil double-precision examples gtk openexr test threads"

RDEPEND=">=dev-libs/zziplib-0.13.36
	>=media-libs/freetype-2.1.10
	threads? ( >=dev-libs/boost-1.33.0 )
	cegui? ( >=dev-games/cegui-0.4.0 )
	devil? ( >=media-libs/devil-1.6.7 )
	openexr? ( >=media-libs/openexr-1.2 )
	gtk? ( >=dev-cpp/gtkmm-2.4 >=dev-cpp/libglademm-2.4 )
	virtual/opengl
	x11-libs/libXaw x11-libs/libXrandr x11-libs/libXt x11-libs/libX11
	sys-libs/zlib"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	dev-util/pkgconfig
	sys-devel/flex
	cg? ( >=media-gfx/nvidia-cg-toolkit-1.2 )
	test? ( dev-util/cppunit )"

S=${WORKDIR}/ogrenew

pkg_setup() {
	if use threads ; then
		if ! built_with_use dev-libs/boost threads ; then
			die "Please emerge dev-libs/boost with USE=threads"
		fi
		if use cegui && has_version '>=dev-games/cegui-0.5'; then
			ewarn "${P} doesn't work with dev-games/cegui-0.5."
			ewarn "Downgrade to dev-games/cegui-0.4 if cegui support is required."
			die "${P} doesn't work with dev-games/cegui-0.5."
		fi

		ewarn "Threads support is experimental in ${PN} and is not recommended."
		ewarn "See http://bugs.gentoo.org/show_bug.cgi?id=144819"
		ewarn "Read the man page for portage by typing \"man portage\""
		ewarn "and read about /etc/portage/package.use for disabling"
		ewarn "the threads use flag for ${PN} without affecting other packages."
		ebeep
		epause 10
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	./bootstrap || die "bootstrap failed"

	find Samples/Media -name CVS -print0 | xargs -0 rm -rf
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
		--disable-dependency-tracking \
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
	emake DESTDIR="${D}" install || die "emake install failed"
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

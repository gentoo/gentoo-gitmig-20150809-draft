# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsfml/libsfml-1.6.ebuild,v 1.2 2011/02/05 05:43:54 radhermit Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6 3"
PYTHON_MODNAME="PySFML"

inherit eutils multilib toolchain-funcs distutils

MY_P="SFML-${PV}"
DESCRIPTION="Simple and Fast Multimedia Library (SFML)"
HOMEPAGE="http://sfml.sourceforge.net/"
SRC_URI="mirror://sourceforge/sfml/${MY_P}-sdk-linux-32.tar.gz
	csfml? ( mirror://sourceforge/sfml/${MY_P}-c-sdk-linux-32.tar.gz )
	python? ( mirror://sourceforge/sfml/${MY_P}-python-sdk.zip )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="csfml debug doc examples python static-libs"

DEPEND="media-libs/freetype:2
	media-libs/glew
	media-libs/libpng
	media-libs/libsndfile
	media-libs/mesa
	media-libs/openal
	sys-libs/zlib
	virtual/jpeg
	x11-libs/libX11
	x11-libs/libXrandr"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch
	epatch "${FILESDIR}"/${P}-deps-and-flags.patch
	if use csfml ; then
		epatch "${FILESDIR}"/${P}-csfml-destdir.patch
	fi
}

src_compile() {
	local myconf

	if use debug ; then
		myconf="$myconf DEBUGBUILD=yes"
	fi

	emake $myconf CPP=$(tc-getCXX) CC=$(tc-getCC) || die "emake failed"

	if use static-libs ; then
		emake $myconf STATIC=yes CPP=$(tc-getCXX) CC=$(tc-getCC) || die "emake failed"
	fi

	if use csfml ; then
		cd "${S}/CSFML"
		emake CPP=$(tc-getCXX) || die "emake failed"
	fi

	if use python ; then
		cd "${S}/python"
		distutils_src_compile
	fi
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr libdir=/usr/$(get_libdir) install || die "emake install failed"

	if use csfml ; then
		pushd "${S}/CSFML" >/dev/null
		emake DESTDIR="${D}" prefix=/usr libdir=/usr/$(get_libdir) install || die "emake install failed"
		popd >/dev/null
	fi

	if use python ; then
		pushd "${S}/python" >/dev/null
		distutils_src_install
		popd >/dev/null
	fi

	if use static-libs ; then
		dolib.a lib/*.a || die "dolib.a failed"
	fi

	if use doc ; then
		dohtml doc/html/*
		if use csfml ; then
			docinto csfml/html
			dohtml CSFML/doc/html/*
		fi
		if use python ; then
			docinto python/html
			dohtml python/doc/*
		fi
	fi

	if use examples ; then
		for i in ftp opengl pong post-fx qt sockets sound sound_capture voip window wxwidgets X11 ; do
			insinto /usr/share/doc/${PF}/examples/$i
			doins samples/$i/* || die "doins failed"
		done

		if use python ; then
			insinto /usr/share/doc/${PF}/python/examples
			doins -r python/samples/* || die "doins failed"
		fi
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}

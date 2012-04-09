# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-9999.ebuild,v 1.17 2012/04/09 21:16:44 xmw Exp $

EAPI=4

EGIT_REPO_URI="git://git.ghostscript.com/mupdf.git"

inherit eutils flag-o-matic git-2 multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="X vanilla"

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	>=media-libs/openjpeg-1.5
	virtual/jpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8.165-buildsystem.patch

	if ! use vanilla ; then
		epatch "${FILESDIR}"/${PN}-9999-zoom-1.patch
	fi
}

src_compile() {
	use X || my_nox11="NOX11=yes MUPDF= "

	emake CC="$(tc-getCC)" \
		build=debug verbose=true ${my_nox11} -j1
}

src_install() {
	emake prefix="${ED}usr" libdir="${ED}usr/$(get_libdir)" \
		build=debug verbose=true ${my_nox11} install

	insinto /usr/include
	doins pdf/mupdf{,-internal}.h
	doins fitz/fitz{,-internal}.h
	doins xps/muxps{,-internal}.h

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc

	if use X ; then
		domenu debian/mupdf.desktop
		doicon debian/mupdf.xpm
	fi
	dodoc README doc/{example.c,overview.txt}
}

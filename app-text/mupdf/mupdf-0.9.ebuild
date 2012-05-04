# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-0.9.ebuild,v 1.8 2012/05/04 03:33:12 jdhore Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI="http://mupdf.com/download/${P}-source.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux"
IUSE="X vanilla"

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	virtual/jpeg
	media-libs/openjpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8.165-buildsystem.patch

	if ! use vanilla ; then
		epatch "${FILESDIR}"/${PN}-0.8.165-zoom.patch
		epatch "${FILESDIR}"/${P}-scroll_hack.patch
		epatch "${FILESDIR}"/${P}-dpi_hack.patch
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

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc

	if use X ; then
		domenu debian/mupdf.desktop
		doicon debian/mupdf.xpm
		doman apps/man/mupdf.1
	fi
	doman apps/man/pdf{clean,draw,show}.1
	dodoc README

	# avoid collision with app-text/poppler-utils
	mv "${ED}"usr/bin/pdfinfo "${ED}"usr/bin/mupdf_pdfinfo || die
}

pkg_postinst() {
	elog "pdfinfo was renamed to mupdf_pdfinfo"
}

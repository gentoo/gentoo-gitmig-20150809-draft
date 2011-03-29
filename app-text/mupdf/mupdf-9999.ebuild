# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-9999.ebuild,v 1.3 2011/03/29 14:13:56 xmw Exp $

EAPI=2

EGIT_REPO_URI="http://mupdf.com/repos/mupdf.git"

inherit eutils flag-o-matic git multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="X vanilla"

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	virtual/jpeg
	media-libs/openjpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8.15-buildsystem.patch

	use vanilla || epatch "${FILESDIR}"/${PN}-0.8.15-zoom.patch
}

src_compile() {
	local my_pdfexe=
	use X || my_pdfexe="PDFVIEW_EXE="

	emake build=debug ${my_pdfexe} CC="$(tc-getCC)" verbose=true -j1 || die
}

src_install() {
	emake build=debug ${my_pdfexe} prefix="${D}usr" \
		LIBDIR="${D}usr/$(get_libdir)" verbose=true install || die

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc || die

	if use X ; then
		domenu debian/mupdf.desktop || die
		doicon debian/mupdf.xpm || die
		doman apps/man/mupdf.1 || die
	fi
	doman apps/man/pdf{clean,draw,show}.1 || die
	dodoc README || die

	# avoid collision with app-text/poppler-utils
	mv "${D}"usr/bin/pdfinfo "${D}"usr/bin/mupdf_pdfinfo || die
}

pkg_postinst() {
	elog "pdfinfo was renamed to mupdf_pdfinfo"
}

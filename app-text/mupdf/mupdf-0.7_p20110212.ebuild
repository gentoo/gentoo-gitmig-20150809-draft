# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-0.7_p20110212.ebuild,v 1.2 2011/02/20 10:26:00 xarthisius Exp $

EAPI=2

inherit eutils multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	virtual/jpeg
	media-libs/openjpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-buildsystem.patch

	epatch "${FILESDIR}"/${P}-zoom.patch

	sed -i -e '/CFLAGS/s: -DNDEBUG : :' Makerules || die
}

src_compile() {
	my_pdfexe=
	use X || my_pdfexe="PDFVIEW_EXE="

	emake build=release ${my_pdfexe} CC="$(tc-getCC)" verbose=true -j1 || die
}

src_install() {
	emake build=release ${my_pdfexe} prefix="${D}usr" \
		LIBDIR="${D}usr/$(get_libdir)" verbose=true install || die

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc || die

	if use X ; then
		domenu debian/mupdf.desktop || die
		doicon debian/mupdf.xpm || die
		doman debian/mupdf.1 || die
	fi
	doman debian/pdf{clean,draw,show}.1 || die
	dodoc README || die

	# avoid collision with app-text/poppler-utils
	mv "${D}"usr/bin/pdfinfo "${D}"usr/bin/mupdf_pdfinfo || die
}

pkg_postinst() {
	elog "pdfinfo was renamed to mupdf_pdfinfo"
}

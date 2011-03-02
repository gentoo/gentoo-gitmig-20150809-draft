# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsbabel/gpsbabel-1.3.6.ebuild,v 1.6 2011/03/02 20:30:51 jlec Exp $

EAPI=2

DESCRIPTION="GPS waypoints, tracks and routes converter"
HOMEPAGE="http://www.gpsbabel.org/"
SRC_URI="http://www.gpsbabel.org/plan9.php?dl=${P}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="doc usb"

RDEPEND="
	dev-libs/expat
	usb? ( dev-libs/libusb )"
DEPEND="${RDEPEND}
	doc? ( dev-java/fop
	virtual/latex-base
	dev-libs/libxslt
	dev-libs/libxml2:2
	dev-lang/perl
	app-text/docbook-xml-dtd:4.1.2 )"

src_configure() {
	econf \
		$(use_with doc doc "${S}"/doc/manual) \
		$(use_with usb libusb) \
		--with-zlib=system
}

src_compile() {
	emake || die
	if use doc; then
		emake doc || die
		cd "${S}/doc"
		emake || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README* || die
	if use doc; then
		cd "${S}"/doc/
		dohtml ./manual/htmldoc-development/* || die
		docinto manual
		dodoc doc.dvi babelfront2.eps ../gpsbabel.pdf || die
	fi
}

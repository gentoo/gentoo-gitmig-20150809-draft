# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdf/qpdf-2.3.1.ebuild,v 1.3 2012/05/23 01:14:06 radhermit Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A command-line program that does structural, content-preserving transformations on PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
SRC_URI="mirror://sourceforge/qpdf/${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static-libs test"

RDEPEND="dev-libs/libpcre
	sys-libs/zlib
	>=dev-lang/perl-5.8"
DEPEND="${RDEPEND}
	test? (
		sys-apps/diffutils
		media-libs/tiff
		app-text/ghostscript-gpl
	)"

DOCS=( ChangeLog README TODO )

src_prepare() {
	# Manually install docs
	sed -i -e "/docdir/d" make/libtool.mk || die

	epatch "${FILESDIR}"/${P}-libpcre-8.30.patch
	epatch "${FILESDIR}"/${P}-gcc47.patch
}

src_install() {
	default

	use static-libs || rm -f "${ED}"/usr/lib*/libqpdf.a

	if use doc ; then
		dodoc doc/qpdf-manual.pdf
		dohtml doc/*
	fi

	if use examples ; then
		dobin examples/build/.libs/*
	fi
}

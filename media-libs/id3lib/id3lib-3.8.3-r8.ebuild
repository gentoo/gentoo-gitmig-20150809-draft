# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib/id3lib-3.8.3-r8.ebuild,v 1.8 2012/02/25 15:06:04 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Id3 library for C/C++"
HOMEPAGE="http://id3lib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="doc"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

RESTRICT="test"

S=${WORKDIR}/${P/_}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-zlib.patch \
		"${FILESDIR}"/${P}-test_io.patch \
		"${FILESDIR}"/${P}-autoconf259.patch \
		"${FILESDIR}"/${P}-doxyinput.patch \
		"${FILESDIR}"/${P}-unicode16.patch \
		"${FILESDIR}"/${P}-gcc-4.3.patch \
		"${FILESDIR}"/${P}-missing_nullpointer_check.patch

	# Security fix for bug 189610.
	epatch "${FILESDIR}"/${P}-security.patch

	AT_M4DIR="${S}/m4" eautoreconf
}

src_compile() {
	emake
	if use doc; then
		cd doc
		doxygen Doxyfile || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog HISTORY README THANKS TODO
	use doc && dohtml -r doc
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libebt/libebt-1.3.0.ebuild,v 1.8 2007/01/31 19:16:42 dertobi123 Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit autotools eutils

DESCRIPTION="A pure C++ template library that provides a clean way of getting human-readable backtrace messages."
HOMEPAGE="http://libebt.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"
RESTRICT="primaryuri"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"
IUSE="doc test"

DEPEND="doc? ( app-doc/doxygen )
		test? ( dev-libs/boost )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	AT_M4DIR=m4
	eautoreconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	use doc && { emake doxygen || die "failed to build API docs" ; }
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
	use doc && dohtml -r doc/html/*
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/clucene/clucene-0.9.21b-r1.ebuild,v 1.1 2010/05/25 06:41:03 reavertm Exp $

EAPI="2"

inherit eutils

MY_P=${PN}-core-${PV}

DESCRIPTION="High-performance, full-featured text search engine based off of lucene in C++"
HOMEPAGE="http://clucene.sourceforge.net/"
SRC_URI="mirror://sourceforge/clucene/${MY_P}.tar.bz2"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug doc static-libs threads"

DEPEND="doc? ( >=app-doc/doxygen-1.4.2 )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch #254254
}

src_configure() {
	econf $(use_enable debug) \
		$(use_enable debug cnddebug) \
		$(use_enable static-libs static) \
		$(use_enable threads multithreading)
}

src_compile() {
	emake || die "emake failed"
	if use doc ; then
		emake doxygen || die "making docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	use doc && dohtml "${S}"/doc/html/*
	if ! use static-libs; then
		find "${D}" -type f -name '*.la' -exec rm -f {} + \
			|| die "la removal failed"
	fi
}

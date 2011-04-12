# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jemalloc/jemalloc-2.2.1-r1.ebuild,v 1.2 2011/04/12 18:18:10 mr_bones_ Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://www.canonware.com/jemalloc/"
SRC_URI="http://www.canonware.com/download/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug stats"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-strip-optimization.patch"
	epatch "${FILESDIR}/${PN}-2.2.1-no-pprof.patch"

	eautoreconf
}

src_configure() {
	econf \
		--with-jemalloc-prefix=j \
		$(use_enable debug) \
		$(use_enable stats) \
		|| die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install
}

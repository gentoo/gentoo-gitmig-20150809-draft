# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jemalloc/jemalloc-2.0.1.ebuild,v 1.1 2010/12/30 14:11:43 anarchy Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://www.canonware.com/jemalloc/"
SRC_URI="http://www.canonware.com/download/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug profile stats"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-strip-optimization.patch"

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable profile prof) \
		$(use_enable stats) \
		|| die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install
}

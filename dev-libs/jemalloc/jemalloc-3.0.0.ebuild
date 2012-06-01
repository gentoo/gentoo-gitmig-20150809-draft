# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jemalloc/jemalloc-3.0.0.ebuild,v 1.1 2012/06/01 13:05:15 anarchy Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://www.canonware.com/jemalloc/"
SRC_URI="http://www.canonware.com/download/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE="debug static-libs stats"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-strip-optimization.patch" \
		"${FILESDIR}/${P}-no-pprof.patch" \
		"${FILESDIR}/${P}_fix_html_install.patch" \

	eautoreconf
}

src_configure() {
	econf \
		--with-jemalloc-prefix=j \
		$(use_enable debug) \
		$(use_enable stats)
}

src_install() {
	emake DESTDIR="${ED}" install || die
	dodoc ChangeLog README
	dohtml doc/jemalloc.html

	use static-libs || find "${ED}" -name '*.a' -exec rm -f {} +
}

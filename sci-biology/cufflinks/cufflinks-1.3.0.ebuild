# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/cufflinks/cufflinks-1.3.0.ebuild,v 1.1 2012/02/05 03:56:55 weaver Exp $

EAPI=4

inherit flag-o-matic autotools

DESCRIPTION="Transcript assembly, differential expression, and differential regulation for RNA-Seq"
HOMEPAGE="http://cufflinks.cbcb.umd.edu/"
SRC_URI="http://cufflinks.cbcb.umd.edu/downloads/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="sci-biology/samtools
	dev-libs/boost:1.46"
RDEPEND="${DEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	filter-ldflags -Wl,--as-needed
	eautoreconf
}

src_configure() {
	econf \
		--with-boost-libdir="${EPREFIX}/usr/$(get_libdir)/boost-1_46" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS
}

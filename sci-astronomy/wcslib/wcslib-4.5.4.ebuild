# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.5.4.ebuild,v 1.1 2010/10/10 01:27:25 bicatali Exp $

EAPI=2
inherit eutils virtualx flag-o-matic autotools

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fortran fits pgplot test"

RDEPEND="fits? ( sci-libs/cfitsio )
	pgplot? ( sci-libs/pgplot )"
DEPEND="${RDEPEND}
	test? ( media-fonts/font-misc-misc
			media-fonts/font-cursor-misc )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.4.4-destdir.patch
	epatch "${FILESDIR}"/${PN}-4.4.4-ldflags.patch
	epatch "${FILESDIR}"/${PN}-4.5.3-fortran.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable fortran) \
		$(use_with fits cfitsio) \
		$(use_with pgplot)
}

src_compile() {
	# -j1 forced. build system too crappy to be worth debugging
	emake -j1 || die "emake failed"
}

src_test() {
	Xemake check || die "emake test failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r *.pdf html || die
	fi
}

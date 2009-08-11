# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.3.3-r1.ebuild,v 1.2 2009/08/11 17:57:46 bicatali Exp $

EAPI=2
inherit eutils versionator virtualx flag-o-matic

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="sci-libs/pgplot
	sci-libs/cfitsio"
DEPEND="${RDEPEND}
	test? (
		media-fonts/font-misc-misc
		media-fonts/font-cursor-misc )"

src_prepare() {
	sed -i \
		-e 's/$(SHRLD)/$(SHRLD) $(LDFLAGS)/' \
		C/GNUmakefile || die
	epatch "${FILESDIR}"/${P}-flibs.patch
	epatch "${FILESDIR}"/${P}-tests.patch
	append-flags -U_FORTIFY_SOURCE
}

src_compile() {
	# -j1 forced. build system too crappy to be worth debugging
	# does not really fix anything
	emake -j1 || die "emake failed"
}

src_test() {
	Xemake -j1 check || die "emake test failed"
}

src_install () {
	# make install from makefile is buggy
	dobin utils/{HPXcvt,fitshdr,wcsgrid} || die "dobin failed"
	WCSV=$(get_version_component_range 1-2)
	dolib.a C/libwcs-${WCSV}.a pgsbox/libpgsbox-${WCSV}.a || die
	dolib.so C/libwcs.so.${WCSV} || die
	dosym libwcs.so.${WCSV} /usr/$(get_libdir)/libwcs.so
	dosym libwcs-${WCSV}.a /usr/$(get_libdir)/libwcs.a
	dosym libpgsbox-${WCSV}.a /usr/$(get_libdir)/libpgsbox.a

	insinto /usr/include/${P}
	doins wcsconfig.h wcsconfig_f77.h || die
	doins pgsbox/*.h C/*.h Fortran/*inc || die
	dosym ${P} /usr/include/${PN}

	dodoc README
	newdoc C/CHANGES CHANGES_C
	newdoc Fortran/CHANGES CHANGES_FORTRAN
	newdoc pgsbox/CHANGES CHANGES_PGSBOX
}

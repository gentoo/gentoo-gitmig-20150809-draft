# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.3.3.ebuild,v 1.1 2009/06/26 21:49:49 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="sci-libs/pgplot
	sci-libs/cfitsio"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e 's/$(SHRLD)/$(SHRLD) $(LDFLAGS)/' \
		C/GNUmakefile || die
}

src_compile() {
	# -j1 forced. build system too crappy to be worth debugging
	emake -j1 || die "emake failed"
}

rc_install() {
   emake DESTDIR="${D}" install || die "emake install failed"
}

src_install () {
	# make install from makefile is buggy

	dobin utils/{HPXcvt,fitshdr,wcsgrid} || die "dobin failed"

	dolib.a C/libwcs-${PV}.a pgsbox/libpgsbox-${PV}.a || die
	dolib.so C/libwcs.so.${PV} || die
	dosym libwcs.so.${PV} /usr/$(get_libdir)/libwcs.so
	dosym libwcs-${PV}.a /usr/$(get_libdir)/libwcs.a
	dosym libpgsbox-${PV}.a /usr/$(get_libdir)/libpgsbox.a

	insinto /usr/include/${P}
	doins wcsconfig.h wcsconfig_f77.h || die
	doins pgsbox/*.h C/*.h Fortran/*inc || die
	dosym ${P} /usr/include/${PN}

	dodoc README
	newdoc C/CHANGES CHANGES_C
	newdoc Fortran/CHANGES CHANGES_FORTRAN
	newdoc pgsbox/CHANGES CHANGES_PGSBOX
}

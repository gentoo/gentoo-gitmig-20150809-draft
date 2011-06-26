# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/metis/metis-5.0_pre2-r1.ebuild,v 1.5 2011/06/26 09:39:04 jlec Exp $

EAPI=4

inherit autotools eutils fortran-2

MY_PV=${PV/_/}

DESCRIPTION="A package for unstructured serial graph partitioning"
HOMEPAGE="http://www-users.cs.umn.edu/~karypis/metis/metis/index.html"
SRC_URI="http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-${MY_PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
LICENSE="free-noncomm"
IUSE="int64 openmp pcre threads"

DEPEND="
	virtual/fortran
	pcre? ( dev-libs/libpcre )"
RDEPEND="${DEPEND}
	!sci-libs/parmetis"

S="${WORKDIR}/metis-${MY_PV}"

pkg_setup() {
	if use openmp; then
		tc-has-openmp || \
			die "Please select an OPENMP capable compiler"
		FORTRAN_NEED_OPENMP=1
	fi
	fortran-2_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	if use int64; then
		sed -e 's/\(#define IDXTYPEWIDTH\).*32/\1 64/' \
			-i include/metis.h \
			|| die "sed for int64 failed"
	fi
	if use threads; then
		sed -e 's/\(#define HAVE_THREADLOCALSTORAGE\).*0/\1 1/' \
			-i include/metis.h \
			|| die "sed for threads failed"
	fi
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable pcre) \
		$(use_enable openmp)
}

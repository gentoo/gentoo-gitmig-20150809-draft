# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/clhep/clhep-2.1.2.2.ebuild,v 1.1 2012/03/02 05:45:13 bicatali Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="High Energy Physics C++ library"
HOMEPAGE="http://www.cern.ch/clhep"
SRC_URI="http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/${P}.tgz"
LICENSE="public-domain"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"

IUSE="exceptions static-libs"
RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PV}/CLHEP"

src_prepare() {
	local d
	for d in $(find . -name configure.ac); do
		# respect user flags and fix some compilers stuff
		sed -i \
			-e 's:^g++):*g++):g' \
			-e 's:^icc):icc|icpc):g' \
			-e '/AM_CXXFLAGS=/s:-O ::g' \
			${d} || die
		# need to rebuild because original configurations
		# have buggy detection
	done
	for d in $(find . -name Makefile.am | xargs grep -l ": %\.cc"); do
		sed -i \
			-e 's|: %\.cc|: %\.cc \$(shareddir)|' \
			-e 's|all-local: \$(shareddir)|all-local: |' \
			${d} || die
		# fixing parallel build
	done
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable exceptions) \
		$(use_enable static-libs static)
}

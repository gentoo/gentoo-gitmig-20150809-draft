# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/clhep/clhep-2.1.2.2.ebuild,v 1.3 2012/06/26 06:09:11 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="High Energy Physics C++ library"
HOMEPAGE="http://www.cern.ch/clhep"
SRC_URI="http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/${P}.tgz"
LICENSE="public-domain"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~amd64-linux ~x86-linux"

IUSE="exceptions static-libs"
RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PV}/CLHEP"

PATCHES=( "${FILESDIR}"/${P}-automake-1.12.patch )

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
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=( $(use_enable exceptions) )
	autotools-utils_src_configure
}

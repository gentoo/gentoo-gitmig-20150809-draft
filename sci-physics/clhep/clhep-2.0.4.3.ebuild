# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/clhep/clhep-2.0.4.3.ebuild,v 1.2 2009/12/07 18:16:11 jer Exp $

EAPI=2
inherit autotools

DESCRIPTION="High Energy Physics C++ library"
HOMEPAGE="http://www.cern.ch/clhep"
SRC_URI="http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/${P}.tgz"
LICENSE="public-domain"
SLOT="2"
KEYWORDS="~amd64 hppa ~ppc ~sparc ~x86"

IUSE="exceptions"
RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PV}/CLHEP"

src_prepare() {
	for d in $(find . -name configure.in); do
		pushd ${d/configure.in/}
		# respect user flags and fix some compilers stuff
		sed -i \
			-e 's:^g++):*g++):g' \
			-e 's:^icc):icc|icpc):g' \
			-e '/AM_CXXFLAGS=/s:-O ::g' \
			configure.in || die
		# need to rebuild because original configurations
		# have buggy detection
		eautoreconf
		popd
	done
}

src_configure() {
	econf $(use_enable exceptions)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog || die
}

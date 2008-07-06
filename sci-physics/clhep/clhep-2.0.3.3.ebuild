# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/clhep/clhep-2.0.3.3.ebuild,v 1.2 2008/07/06 23:11:49 jer Exp $

inherit autotools flag-o-matic toolchain-funcs

DESCRIPTION="High Energy Physics C++ library"
HOMEPAGE="http://www.cern.ch/clhep"
SRC_URI="http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/distributions/${P}-src.tgz"

LICENSE="public-domain"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~x86"

IUSE="exceptions"
RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PV}/CLHEP"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
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
		eautoconf
		popd
	done
}

src_compile() {
	# use ld LDFLAGS for intel compiler
	[[ $(tc-getCXX) = i*c ]] && \
		export LDFLAGS="$(raw-ldflags)"
	econf $(use_enable exceptions) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog || die
}

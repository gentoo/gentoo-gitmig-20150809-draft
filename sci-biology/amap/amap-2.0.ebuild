# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/amap/amap-2.0.ebuild,v 1.1 2006/12/11 06:59:29 dberkholz Exp $

inherit eutils toolchain-funcs

MY_P="${PN}.${PV}"
DESCRIPTION="Protein multiple-alignment-based sequence annealing"
HOMEPAGE="http://bio.math.berkeley.edu/amap/"
SRC_URI="http://bio.math.berkeley.edu/amap/download/${MY_P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-fix-cxxflags.patch
}

src_compile() {
	emake \
		CXX="$(tc-getCXX)" \
		OPT_CXXFLAGS="${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin ${PN}
	dodoc README PROBCONS.README
}

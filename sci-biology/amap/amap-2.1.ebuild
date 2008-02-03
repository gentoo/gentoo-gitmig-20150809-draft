# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/amap/amap-2.1.ebuild,v 1.2 2008/02/03 04:37:36 je_fro Exp $

inherit eutils toolchain-funcs

MY_P="${PN}.${PV}"
DESCRIPTION="Protein multiple-alignment-based sequence annealing"
HOMEPAGE="http://bio.math.berkeley.edu/amap/"
SRC_URI="http://bio.math.berkeley.edu/amap/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}-align"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-fix-cxxflags.patch
}

src_compile() {
	cd "${S}"/align
	emake \
		CXX="$(tc-getCXX)" \
		OPT_CXXFLAGS="${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin align/${PN}
	dodoc align/README align/PROBCONS.README
	insinto /usr/share/${PN}/examples
	doins examples/* || die "Failed to install examples"
}

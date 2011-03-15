# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ariadne/ariadne-1.3-r2.ebuild,v 1.1 2011/03/15 18:39:51 xarthisius Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Protein sequences and profiles comparison"
LICENSE="as-is"
HOMEPAGE="http://www.well.ox.ac.uk/ariadne/"
SRC_URI="http://www.well.ox.ac.uk/${PN}/${P}.tar.Z"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=sci-biology/ncbi-tools-20041020-r1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/SRC-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-implicits.patch
	sed -i -e "s/\$(CFLAGS)/\$(LDFLAGS) &/" Makefile || die #359045
	sed -e "s/blosum62/BLOSUM62/" -i prospero.c || die
}

src_compile() {
	emake CC="$(tc-getCC)" OPTIMISE="${CFLAGS}" || die
}

src_install() {
	dobin Linux/{ariadne,prospero} || die
	dolib Linux/libseq.a || die
	insinto /usr/include/${PN}
	doins Include/*.h || die
	dodoc README || die
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ariadne/ariadne-1.3-r2.ebuild,v 1.2 2012/06/14 19:01:19 jlec Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Protein sequences and profiles comparison"
HOMEPAGE="http://www.well.ox.ac.uk/ariadne/"
SRC_URI="http://www.well.ox.ac.uk/${PN}/${P}.tar.Z"

SLOT="0"
LICENSE="as-is"
IUSE="static-libs"
KEYWORDS="~amd64 ~x86"

DEPEND=">=sci-biology/ncbi-tools-0.20041020-r1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/SRC-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-implicits.patch
	sed -i -e "s/\$(CFLAGS)/\$(LDFLAGS) &/" Makefile || die #359045
	sed -e "s/blosum62/BLOSUM62/" -i prospero.c || die
}

src_compile() {
	emake CC="$(tc-getCC)" OPTIMISE="${CFLAGS}"
}

src_install() {
	dobin Linux/{ariadne,prospero}
	use static-libs && dolib.a Linux/libseq.a
	insinto /usr/include/${PN}
	doins Include/*.h || die
	dodoc README || die
}

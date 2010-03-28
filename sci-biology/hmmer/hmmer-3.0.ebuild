# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/hmmer/hmmer-3.0.ebuild,v 1.1 2010/03/28 20:51:02 weaver Exp $

EAPI="2"

DESCRIPTION="Sequence analysis using profile hidden Markov models"
HOMEPAGE="http://hmmer.janelia.org/"
SRC_URI="ftp://selab.janelia.org/pub/software/hmmer3/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="+sse mpi +threads gsl"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

DEPEND="mpi? ( virtual/mpi )
	gsl? ( >=sci-libs/gsl-1.12 )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable sse) \
		$(use_enable mpi) \
		$(use_enable threads) \
		$(use_with gsl) || die
}

src_install() {
	einstall || die
	dolib src/libhmmer.a || die
	dolib easel/libeasel.a || die
	insinto /usr/share/${PN}
	doins -r tutorial || die
	dodoc RELEASE-NOTES Userguide.pdf
}

src_test() {
	emake check || die
}

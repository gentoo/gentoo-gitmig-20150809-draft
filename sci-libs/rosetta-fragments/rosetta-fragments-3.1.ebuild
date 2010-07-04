# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/rosetta-fragments/rosetta-fragments-3.1.ebuild,v 1.2 2010/07/04 08:07:04 jlec Exp $

EAPI="2"

inherit flag-o-matic fortran

DESCRIPTION="Fragment library for rosetta"
HOMEPAGE="http://www.rosettacommons.org"
SRC_URI="rosetta3.1_fragments.tgz"

LICENSE="rosetta"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch"

RDEPEND="
	sci-biology/ncbi-tools
	sci-biology/ncbi-tools++
	sci-biology/psipred"

S="${WORKDIR}"/${PN/-/_}

FORTRAN="g77 gfortran ifc"

pkg_nofetch() {
	einfo "Go to ${HOMEPAGE} and get ${PN}.tgz and rename it to ${A}"
	einfo "which must be placed in ${DISTDIR}"
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-nnmake.patch
	epatch "${FILESDIR}"/${PV}-chemshift.patch
}

src_compile() {
	append-fflags -ffixed-line-length-132

	cd "${S}"/nnmake && \
	emake || die

	cd "${S}"/chemshift && \
	emake || die
}

src_install() {
	find . -type d -name ".svn" -exec rm -rf '{}' \; 2> /dev/null

	newbin nnmake/pNNMAKE.gnu pNNMAKE && \
	newbin chemshift/pCHEMSHIFT.gnu pCHEMSHIFT || \
	die "failed to install the bins"

	dobin nnmake/*.pl || die "no additional perl scripts"

	insinto /usr/share/${PN}
	doins -r *_database || die
	dodoc fragments.README nnmake/{nnmake.README,vall/*.pl} chemshift/chemshift.README || die "no docs"
}

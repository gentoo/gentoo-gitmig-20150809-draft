# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/paml/paml-4.1.ebuild,v 1.1 2008/09/07 12:02:02 markusle Exp $

inherit toolchain-funcs

MY_PV="${PV/./}"
DESCRIPTION="Phylogenetic Analysis by Maximum Likelihood"
HOMEPAGE="http://abacus.gene.ucl.ac.uk/software/paml.html"
SRC_URI="http://abacus.gene.ucl.ac.uk/software/${PN}${PV}.tar.gz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}${MY_PV}"

src_compile() {
	cd src
	emake \
		-f Makefile.UNIX \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "make failed"
}

src_install() {
	pushd "${S}"/src
	dobin baseml codeml basemlg mcmctree pamp evolver yn00 chi2 \
		|| die "Failed to install binaries"
	popd

	dodoc README.txt doc/* || die "Failed to install docs"

	insinto /usr/share/${PN}/control
	doins *.ctl || die "Failed to install control files"

	insinto /usr/share/${PN}/dat
	doins stewart* *.dat dat/* || die "Failed to install data files"

	insinto /usr/share/${PN}
	doins -r examples/ || die "Failed to install examples"
}

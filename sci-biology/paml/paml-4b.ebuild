# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/paml/paml-4b.ebuild,v 1.1 2008/04/20 11:11:20 markusle Exp $

inherit toolchain-funcs

MY_PV="${PV:0:1}"
MY_P="${PN}${MY_PV}"
DESCRIPTION="Phylogenetic Analysis by Maximum Likelihood"
HOMEPAGE="http://abacus.gene.ucl.ac.uk/software/paml.html"
SRC_URI="http://abacus.gene.ucl.ac.uk/software/${PN}${PV}.tar.gz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

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
	dobin baseml codeml basemlg mcmctree pamp evolver yn00 chi2
	popd
	dodoc README.txt doc/*
	insinto /usr/share/${PN}/control
	doins *.ctl || die "Failed to install control files"
	insinto /usr/share/${PN}/dat
	doins stewart* *.dat dat/* || die "Failed to install data files"
	insinto /usr/share/${PN}
	doins -r examples/ || die "Failed to install examples"
}

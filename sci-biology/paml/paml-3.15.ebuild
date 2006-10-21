# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/paml/paml-3.15.ebuild,v 1.1 2006/10/21 05:57:50 dberkholz Exp $

inherit toolchain-funcs

MY_P="${P/-}"
DESCRIPTION="Phylogenetic Analysis by Maximum Likelihood"
HOMEPAGE="http://abacus.gene.ucl.ac.uk/software/paml.html"
SRC_URI="http://abacus.gene.ucl.ac.uk/software/${MY_P}.tar.gz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
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
}

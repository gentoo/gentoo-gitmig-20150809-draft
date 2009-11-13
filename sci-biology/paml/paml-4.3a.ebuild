# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/paml/paml-4.3a.ebuild,v 1.1 2009/11/13 15:36:55 weaver Exp $

EAPI="2"

inherit toolchain-funcs

MY_P="${PN}43"
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

src_prepare() {
	sed -i 's/-static//' "${S}/src/Makefile.UNIX" || die
}

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
	dobin baseml codeml basemlg mcmctree pamp evolver yn00 chi2 || die
	popd
	dodoc README.txt doc/*
	insinto /usr/share/${PN}/control
	doins *.ctl || die "Failed to install control files"
	insinto /usr/share/${PN}/dat
	doins stewart* *.dat dat/* || die "Failed to install data files"
	insinto /usr/share/${PN}
	doins -r examples/ || die "Failed to install examples"
}

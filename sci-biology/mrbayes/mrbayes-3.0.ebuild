# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mrbayes/mrbayes-3.0.ebuild,v 1.3 2005/02/20 05:47:16 j4rg0n Exp $

inherit eutils toolchain-funcs

SRC_PACKAGE="MrBayes_V3.0_src"

DESCRIPTION="Bayesian Inference of Phylogeny"
HOMEPAGE="http://morphbank.ebc.uu.se/mrbayes/"
SRC_URI="${SRC_PACKAGE}.tar"
RESTRICT="fetch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc-macos"
IUSE=""

S="${WORKDIR}/${SRC_PACKAGE}/"

pkg_nofetch() {
	einfo "Please download"
	einfo " - ${SRC_URI}"
	einfo "from ${HOMEPAGE}/download.php and place them in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# TODO: Implement MPI-aware ebuild/use flags, etc. to use Makefile-Mpi

	# Fix the non-standard Makefile.
	sed -i \
		-e "s:-O4:${CFLAGS}:" \
		-e "s:gcc:$(tc-getCC):" \
		Makefile || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		|| die "emake failed"
}

src_install() {
	# Non-standard manual install
	into /usr
	dobin mb
}

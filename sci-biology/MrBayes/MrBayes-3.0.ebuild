# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/MrBayes/MrBayes-3.0.ebuild,v 1.2 2005/01/30 16:35:05 ribosome Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Bayesian Inference of Phylogeny"
HOMEPAGE="http://morphbank.ebc.uu.se/mrbayes/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc-macos"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# TODO: Implement MPI-aware ebuild/use flags, etc. to use Makefile-Mpi

	# Fix the non-standard Makefile.
	sed -i \
		-e "s:-O4:${CFLAGS}:" \
		-e "s:gcc:${CC}:" \
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

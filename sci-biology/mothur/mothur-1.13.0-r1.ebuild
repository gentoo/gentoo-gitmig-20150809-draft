# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mothur/mothur-1.13.0-r1.ebuild,v 1.2 2011/07/08 10:58:34 ssuominen Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A suite of algorithms for ecological bioinformatics"
HOMEPAGE="http://schloss.micro.umass.edu/wiki/Main_Page"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
IUSE="mpi +readline"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}
	app-arch/unzip"
RDEPEND="mpi? ( virtual/mpi )"

S=${WORKDIR}/Mothur.source

pkg_setup() {
	use mpi && CXX=mpicxx || CXX=$(tc-getCXX)
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-overflows.patch
}

use_yn() {
	use $1 && echo "yes" || echo "no"
}

src_compile() {
	emake USEMPI=$(use_yn mpi) USEREADLINE=$(use_yn readline) || die
}

src_install() {
	dobin mothur || die
}

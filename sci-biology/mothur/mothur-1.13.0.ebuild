# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mothur/mothur-1.13.0.ebuild,v 1.1 2010/09/26 02:30:24 weaver Exp $

EAPI="2"

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A suite of algorithms for ecological bioinformatics"
HOMEPAGE="http://schloss.micro.umass.edu/wiki/Main_Page"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
IUSE="mpi +readline"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	mpi? ( virtual/mpi )"
RDEPEND=""

S="${WORKDIR}/Mothur.source"

src_prepare() {
	filter-ldflags -Wl,--as-needed
	sed -i -e 's/CC_OPTIONS =/CC_OPTIONS = ${CXXFLAGS} /' \
		-e '/USEMPI ?=/ d' -e '/USEREADLINE ?=/ d' \
		-e 's|CC = g++|CC = '$(tc-getCXX)'|' "${S}/makefile" || die

	use mpi && sed -i '1 a USEMPI = yes' "${S}/makefile"
	use readline && sed -i '1 a USEREADLINE = yes' "${S}/makefile"
}

src_install() {
	dobin mothur || die
}

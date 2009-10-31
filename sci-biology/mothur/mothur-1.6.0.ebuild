# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mothur/mothur-1.6.0.ebuild,v 1.1 2009/10/31 22:10:04 weaver Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="A suite of algorithms for ecological bioinformatics"
HOMEPAGE="http://schloss.micro.umass.edu/wiki/Main_Page"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/mothur-v.${PV}"

src_prepare() {
	sed -i -e 's/CC_OPTIONS =/CC_OPTIONS = ${CXXFLAGS} /' \
		-e 's|CC = g++|CC = '$(tc-getCXX)'|' "${S}/makefile" || die
}

src_install() {
	dobin mothur || die
}

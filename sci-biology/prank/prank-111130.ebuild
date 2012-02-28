# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prank/prank-111130.ebuild,v 1.1 2012/02/28 05:37:06 weaver Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Probabilistic Alignment Kit"
HOMEPAGE="http://code.google.com/p/prank-msa/ http://www.ebi.ac.uk/goldman-srv/prank/prank/"
SRC_URI="http://prank-msa.googlecode.com/files/prank.src.${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/prank-msa/src"

src_prepare() {
	sed -i -e "s/\$(LINK)/& \$(LDFLAGS)/" Makefile || die
}

src_compile() {
	emake LINK="$(tc-getCXX)" CFLAGS="${CFLAGS}" \
		CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin prank || die
}

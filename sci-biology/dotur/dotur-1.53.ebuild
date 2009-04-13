# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/dotur/dotur-1.53.ebuild,v 1.1 2009/04/13 01:06:44 weaver Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Distance Based OTU and Richness Determination for DNA sequences"
HOMEPAGE="http://schloss.micro.umass.edu/software/dotur.html"
SRC_URI="http://schloss.micro.umass.edu/software/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/DOTUR-${PV}"

src_compile() {
	sed -i '1 i #include <string.h>\n#include <algorithm>' dotur.C
	$(tc-getCXX) ${CXXFLAGS} -O3 dotur.C -o dotur || die
}

src_install() {
	dobin dotur || die
	dodoc README
}

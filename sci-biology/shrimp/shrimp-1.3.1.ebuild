# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/shrimp/shrimp-1.3.1.ebuild,v 1.1 2009/12/09 18:52:14 weaver Exp $

EAPI="2"

MY_PV=${PV//./_}

DESCRIPTION="SHort Read Mapping Package"
HOMEPAGE="http://compbio.cs.toronto.edu/shrimp/"
SRC_URI="http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_${MY_PV}.src.tar.gz"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/SHRiMP_${MY_PV}"

src_prepare() {
	sed -i -e '1 a #include <stdint.h>' common/dag_glue.cpp || die
	sed -i -e '1 a CXXFLAGS+= -O3 -mmmx -msse -msse2' \
		-e 's/-static//' "${S}/Makefile" || die
}

src_install() {
	rm bin/README
	dobin bin/* || die
	insinto /usr/share/${PN}
	doins -r utils || die
	dodoc HISTORY README TODO MEMORY
}

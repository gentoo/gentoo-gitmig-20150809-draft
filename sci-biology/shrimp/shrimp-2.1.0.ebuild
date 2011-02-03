# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/shrimp/shrimp-2.1.0.ebuild,v 1.1 2011/02/03 00:13:49 weaver Exp $

EAPI="2"

inherit flag-o-matic toolchain-funcs

MY_PV=${PV//./_}

DESCRIPTION="SHort Read Mapping Package"
HOMEPAGE="http://compbio.cs.toronto.edu/shrimp/"
SRC_URI="http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_${MY_PV}.src.tar.gz"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=sys-devel/gcc-4.3[openmp]"
RDEPEND="${DEPEND}"  # -lgomp

S=${WORKDIR}/SHRiMP_${MY_PV}

pkg_setup() {
	tc-has-openmp || die "At least gcc-4.3 is required for openmp support."
}

src_prepare() {
	sed -i -e '1 a #include <stdint.h>' common/dag_glue.cpp || die #294811
	# respect LDFLAGS wrt 331823
	sed -i -e "s/LDFLAGS/LIBS/" -e "s/\$(LD)/& \$(LDFLAGS)/" \
		-e 's/-static//' Makefile || die
}

src_compile() {
	append-flags -fopenmp -O3 # per instructions in BUILDING
	tc-export CXX
	emake CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin bin/* || die
	insinto /usr/share/${PN}
	doins -r utils || die
	dodoc HISTORY README TODO SPLITTING_AND_MERGING || die
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/tinker/tinker-5.1.05.ebuild,v 1.2 2010/04/09 13:33:24 jlec Exp $

EAPI="2"
FORTRAN="gfortran ifc"

inherit fortran

DESCRIPTION="Molecular modeling package that includes force fields, such as AMBER and CHARMM."
HOMEPAGE="http://dasher.wustl.edu/tinker/"
SRC_URI="http://dasher.wustl.edu/tinker/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="Tinker"
KEYWORDS="~amd64 ~x86 ~x86-linux"
IUSE=""

# RDEPEND="dev-java/j3d-core"
RDEPEND="!dev-util/tinker"
RESTRICT="mirror"

S="${WORKDIR}"/tinker/source

src_compile() {
	emake \
		-f ../make/Makefile \
		F77="${FORTRANC}" \
		F77FLAGS=-c \
		OPTFLAGS="${FFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		|| die
}

src_install() {
	dodoc \
		"${WORKDIR}"/tinker/doc/{*.txt,announce/release-*,*.pdf,0README} || die

	dolib.a libtinker.a || die

	for EXE in *.x; do
		newbin ${EXE} ${EXE%.x} || die
	done

	docinto example
	dodoc "${WORKDIR}"/tinker/example/* || die

	docinto test
	dodoc "${WORKDIR}"/tinker/test/* || die

	dobin "${WORKDIR}"/tinker/perl/mdavg || die

	insinto /usr/share/tinker/params
	doins "${WORKDIR}"/tinker/params/* || die
}

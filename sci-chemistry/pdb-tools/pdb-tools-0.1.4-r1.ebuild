# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb-tools/pdb-tools-0.1.4-r1.ebuild,v 1.1 2010/10/28 16:43:25 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python fortran

DESCRIPTION="A set of tools for manipulating and doing calculations on wwPDB macromolecule structure files"
HOMEPAGE="http://code.google.com/p/pdb-tools"
SRC_URI="http://${PN}.googlecode.com/files/${PN}_${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE=""

RDEPEND="sci-chemistry/dssp"
DEPEND=""

FORTRANC="ifc gfortran"

S="${WORKDIR}"/${PN}_${PV}

pkg_setup() {
	python_set_active_version 2
	fortran_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	PDB_PY="$(ls pdb_*.py)"
	sed "s:script_dir,\"pdb_data\":\"${EPREFIX}/usr/share/${PN}\",\"pdb_data\":g" -i pdb_sasa.py || die
	sed "/satk_path =/s:^.*$:satk_path = \"${EPREFIX}/usr/bin\":g" -i pdb_satk.py || die
}

src_compile() {
	mkdir bin
	cd satk
	for i in *.f; do
		einfo "${FORTRANC} ${FFLAGS} ${LDFLAGS} ${i} -o ${i/.f}"
		${FORTRANC} ${FFLAGS} -c ${i} -o ${i/.f/.o} || die
		${FORTRANC} ${LDFLAGS} -o ../bin/${i/.f} ${i/.f/.o} || die
		sed "s:${i/.f}.out:${i/.f}:g" -i ../pdb_satk.py || die
	done
}

src_install() {
	insinto /usr/share/${PN}
	doins -r pdb_data/peptides || die
	rm -rf pdb_data/peptides || die

	insinto $(python_get_sitedir)
	doins -r *.py helper pdb_data || die

	for i in ${PDB_PY}; do
		cat >> ${i/.py} <<- EOF
		#!${EPREFIX}/bin/bash
		$(PYTHON) -O "${EPREFIX}"$(python_get_sitedir)/${i} \$@
		EOF
		dobin ${i/.py}
	done

	dobin bin/* || die
	dodoc README || die
}

pkg_postinst() {
	python_mod_optimize ${PDB_PY} helper pdb_data
}

pkg_postrm() {
	python_mod_cleanup ${PDB_PY} helper pdb_data
}

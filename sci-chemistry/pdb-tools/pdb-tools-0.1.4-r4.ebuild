# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb-tools/pdb-tools-0.1.4-r4.ebuild,v 1.1 2013/04/16 08:41:10 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy{1_8,1_9} )

inherit fortran-2 python-r1 toolchain-funcs

DESCRIPTION="Tools for manipulating and doing calculations on wwPDB macromolecule structure files"
HOMEPAGE="http://code.google.com/p/pdb-tools/"
SRC_URI="http://${PN}.googlecode.com/files/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="sci-chemistry/dssp"
DEPEND=""

S="${WORKDIR}"/${PN}_${PV}

src_prepare() {
	sed \
		-e "s:script_dir,\"pdb_data\":\"${EPREFIX}/usr/share/${PN}\",\"pdb_data\":g" \
		-i pdb_sasa.py || die
	sed \
		-e "/satk_path =/s:^.*$:satk_path = \"${EPREFIX}/usr/bin\":g" \
		-i pdb_satk.py || die
}

src_compile() {
	mkdir bin
	cd satk
	for i in *.f; do
		einfo "$(tc-getFC) ${FFLAGS} ${LDFLAGS} ${i} -o ${i/.f}"
		$(tc-getFC) ${FFLAGS} -c ${i} -o ${i/.f/.o} || die
		$(tc-getFC) ${LDFLAGS} -o ../bin/${i/.f} ${i/.f/.o} || die
		sed \
			-e "s:${i/.f}.out:${i/.f}:g" \
			-i ../pdb_satk.py || die
	done
}

src_install() {
	local script
	insinto /usr/share/${PN}
	doins -r pdb_data/peptides
	rm -rf pdb_data/peptides || die

	for script in pdb_*.py; do
		python_foreach_impl python_newscript ${script} ${script%.py}
	done

	python_foreach_impl python_domodule helper pdb_data

	python_moduleinto ${PN}
	python_foreach_impl python_domodule *.py

	dobin bin/*
	dodoc README
}

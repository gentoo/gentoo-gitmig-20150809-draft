# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/reduce/reduce-3.13.080428.ebuild,v 1.2 2009/05/29 00:43:56 dberkholz Exp $

# If you want to fix the warnings about friend declaration 'foo' declared as
# a non-template function, see http://gcc.gnu.org/faq.html#friend.

inherit eutils toolchain-funcs

MY_P="${PN}.${PV}.src"
DESCRIPTION="Adds hydrogens to a Protein Data Bank (PDB) molecule structure file"
HOMEPAGE="http://kinemage.biochem.duke.edu/software/reduce.php"
SRC_URI="http://kinemage.biochem.duke.edu/downloads/software/reduce31/${MY_P}.tgz"
LICENSE="richardson"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	DICT_DIR="/usr/share/reduce"
	DICT_FILE="reduce_het_dict.txt"
	DICT_LOC="${DICT_DIR}/${DICT_FILE}"

	unpack ${A}
	cd "${S}"

	einfo "Fixing location of dictionary"
	sed -i \
		-e "s:^\(DICT_HOME.*=\).*:\1 ${DICT_LOC}:g" \
		"${S}"/*/Makefile
}

src_compile() {
	emake \
		CXX="$(tc-getCXX)" \
		OPT="${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin "${S}"/reduce_src/reduce || die
	insinto ${DICT_DIR}
	doins "${S}"/${DICT_FILE} "${S}"/reduce_wwPDB_het_dict.txt || die
	dodoc README.usingReduce.txt || die
}

pkg_info() {
	elog "To use the PDBv3 dictionary instead of PDBv2, set the environment"
	elog "variable REDUCE_HET_DICT to /usr/share/reduce/reduce_wwPDB_het_dict.txt"
}

pkg_postinst() {
	pkg_info
}

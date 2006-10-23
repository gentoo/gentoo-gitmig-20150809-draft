# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/reduce/reduce-2.21.030604.ebuild,v 1.4 2006/10/23 03:55:16 dberkholz Exp $

# If you want to fix the warnings about friend declaration 'foo' declared as
# a non-template function, see http://gcc.gnu.org/faq.html#friend.

inherit eutils toolchain-funcs

MY_P="${PN}.${PV}"
DESCRIPTION="Adds hydrogens to a Protein Data Bank (PDB) molecule structure file"
HOMEPAGE="http://kinemage.biochem.duke.edu/software/reduce.php"
SRC_URI="http://kinemage.biochem.duke.edu/downloads/software/reduce/${MY_P}.src.tgz
	http://kinemage.biochem.duke.edu/downloads/software/reduce/reduce_het_dict.txt.zip"
LICENSE="richardson"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"
S="${WORKDIR}/${MY_P}.source"

src_unpack() {
	DICT_DIR="/usr/$(get_libdir)/reduce"
	DICT_FILE="reduce_het_dict.txt"
	DICT_LOC="${DICT_DIR}/${DICT_FILE}"

	unpack ${A}
	epatch ${FILESDIR}/${PV}-gcc4.patch

	# Get Makefiles that are at least somewhere close to right
	einfo "Updating Makefiles"
	for dir in libpdb reduce_src toolclasses; do
		pushd "${S}"/${dir} > /dev/null
		mv Makefile Makefile.old
		mv Makefile.g++ Makefile
		popd > /dev/null
	done

	# Do after replacing Makefiles
	einfo "Fixing CFLAGS and locations"
	sed -i \
		-e "s:^\(DICT_HOME\).*:\1 = ${DICT_LOC}:g" \
		-e "s:-DBRACKETOPERPARMS::g" \
		"${S}"/*/Makefile
}

src_compile() {
	emake \
		CXX="$(tc-getCXX)" \
		OPT="${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin ${S}/reduce_src/reduce
	dodoc ${S}/README*
	insinto ${DICT_DIR}
	doins ${WORKDIR}/${DICT_FILE}
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/maxit/maxit-8.2.ebuild,v 1.4 2007/03/15 17:38:54 kugelfang Exp $

inherit eutils toolchain-funcs multilib

# pdb-extract includes a newer 'validation' than 'validation' tarball does,
# and the filterlib from pdb-extract is incompatible with the validation tarball
MY_PN="pdb-extract"
MY_PV="1.700"
MY_P="${MY_PN}-v${MY_PV}-prod-src"
DESCRIPTION="An application for processing and curation of macromolecular structure data"
HOMEPAGE="http://sw-tools.pdb.org/apps/MAXIT/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/PDB_EXTRACT/${MY_P}.tar.gz"
LICENSE="PDB"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="sci-libs/rcsb-data"
DEPEND="${RDEPEND}
	sci-chemistry/pdb-extract
	sci-chemistry/validation"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/respect-cflags-and-fix-install.patch
	cd ${S}

	# Get rid of unneeded directories, to make sure we use system files
	ebegin "Deleting redundant directories"
	rm -rf btree-obj* ciflib-common* cifobj-common* cif-table-obj* misclib* \
		regex* pdb-extract* validation*
	eend

	sed -i \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		-e "s:^\(GINCLUDE=\).*:\1-I/usr/include/rcsb:g" \
		-e "s:^\(LIBDIR=\).*:\1/usr/$(get_libdir):g" \
		${S}/etc/make.*
}

src_install() {
	exeinto /usr/bin
	doexe bin/*
	dolib.a lib/*
	dodoc ${FILESDIR}/README*
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb-extract/pdb-extract-3.004.ebuild,v 1.1 2009/12/04 02:49:38 markusle Exp $

EAPI="2"

inherit eutils toolchain-funcs multilib

MY_P="${PN}-v${PV}-prod-src"
DESCRIPTION="Tools for extracting mmCIF data from structure determination applications"
HOMEPAGE="http://sw-tools.pdb.org/apps/PDB_EXTRACT/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/PDB_EXTRACT/${MY_P}.tar.gz"
LICENSE="PDB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="!<app-text/html-xml-utils-5.3"
DEPEND="${RDEPEND}
	>=sci-libs/cifparse-obj-7.025"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-cflags-install.patch
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-env.patch

	sed -i "s:GENTOOLIBDIR:$(get_libdir):g" \
		pdb-extract-v3.0/Makefile \
		|| die "Failed to fix libdir"

	# Get rid of unneeded directories, to make sure we use system files
	ebegin "Deleting redundant directories"
	rm -rf cif-file-v1.0 cifobj-common-v4.1 cifparse-obj-v7.0 \
		misclib-v2.2 regex-v2.2 tables-v8.0
	eend

	sed -i \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		-e "s:^\(CC=\).*:\1$(tc-getCC):g" \
		-e "s:^\(GINCLUDES=\).*:\1-I/usr/include/cifparse-obj:g" \
		-e "s:^\(LIBDIR=\).*:\1/usr/$(get_libdir):g" \
		"${S}"/etc/make.* \
		|| die "Failed to fix makefiles"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin bin/pdb_extract{,_sf} \
		|| die "failed to install binaries"
	newbin bin/extract extract-pdb \
		|| die "failed to rename extract binary"
	dolib.a lib/pdb-extract.a  \
		|| die "failed to install library"
	insinto /usr/include/rcsb
	doins include/* \
		|| die "failed to install include files"
	dodoc README-source README \
		|| die "failed to install docs"
	insinto /usr/lib/rcsb/pdb-extract-data
	doins pdb-extract-data/*  \
		|| die "failed to install data files"

	cat >> "${T}"/envd <<- EOF
	PDB_EXTRACT="/usr/lib/rcsb/"
	PDB_EXTRACT_ROOT="/usr/"
	EOF

	newenvd "${T}"/envd 20pdb-extract \
		|| "failed to install env files"
}

pkg_postinst() {
	ewarn "We moved extract to extract-pdb due to multiple collision of /usr/bin/extract"
}

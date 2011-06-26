# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scotch/scotch-5.1.11.ebuild,v 1.3 2011/06/26 10:08:23 jlec Exp $

EAPI=4

inherit eutils toolchain-funcs versionator

# use esmumps version to allow linking with mumps
MYP="${PN}_${PV}_esmumps"
# download id on gforge changes every goddamn release
DID=28044

DESCRIPTION="Software for graph, mesh and hypergraph partitioning"
HOMEPAGE="http://www.labri.u-bordeaux.fr/perso/pelegrin/scotch/"
SRC_URI="http://gforge.inria.fr/frs/download.php/${DID}/${MYP}.tgz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples mpi static-libs"

RDEPEND="
	sys-libs/zlib
	mpi? ( virtual/mpi )"
DEPEND="${RDEPEND}
	sys-devel/bison"

S="${WORKDIR}/${MYP}/src"

make_shared_lib() {
	local soname=$(basename "${1%.a}").so.$(get_major_version)
	einfo "Making ${soname}"
	${2:-$(tc-getCC)} ${LDFLAGS}  \
		-shared -Wl,-soname="${soname}" \
		-Wl,--whole-archive "${1}" -Wl,--no-whole-archive \
		-lz -lm -lrt -o $(dirname "${1}")/"${soname}" || return 1
}

src_prepare() {
	epatch \
		"${FILESDIR}"/metis-header.patch \
		"${FILESDIR}"/respect-ldflags.patch
	sed \
		-e "s/@CFLAGS@/${CFLAGS}/" \
		-e "s/@CC@/$(tc-getCC)/" \
		-e "s/@AR@/$(tc-getAR)/" \
		-e "s/@RANLIB@/$(tc-getRANLIB)/" \
		"${FILESDIR}"/Makefile.inc.in > Makefile.inc || die
}

src_compile() {
	emake PICFLAGS=-fPIC
	local lib
	for lib in $(find . -name lib\*.a); do
		make_shared_lib ${lib} || die "shared ${lib} failed"
	done
	if use mpi; then
		emake PICFLAGS=-fPIC ptscotch
		for lib in $(find . -name libpt\*.a); do
			make_shared_lib ${lib} mpicc || die "shared ${lib} failed"
		done
	fi
	if use static-libs; then
		emake clean
		emake
		use mpi && emake ptscotch
	fi
}

src_install() {
	cd ..
	local l b m
	for l in $(find . -name \*.so.\*); do
		dolib.so ${l}
		dosym $(basename ${l}) /usr/$(get_libdir)/$(basename ${l%.*})
	done
	use static-libs && dolib.a $(find . -name \*.a)

	pushd bin > /dev/null
	for b in *; do
		newbin ${b} scotch_${b}
	done
	popd

	pushd man/man1 > /dev/null
	for m in *; do
		newman ${m} scotch_${m}
	done
	popd > /dev/null

	insinto /usr/include/scotch
	doins include/*

	dodoc README.txt

	use doc && dodoc doc/*.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* tgt grf
	fi
}

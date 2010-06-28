# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cbflib/cbflib-0.9.0.ebuild,v 1.2 2010/06/28 22:41:23 angelos Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

MY_P1="CBFlib-${PV}"
MY_P2="CBFlib_${PV}"

DESCRIPTION="Library providing a simple mechanism for accessing CBF files and imgCIF files."
HOMEPAGE="http://www.bernstein-plus-sons.com/software/CBF/"
#BASE_TEST_URI="http://arcib.dowling.edu/software/CBFlib/downloads/version_${PV}/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P1}_14Feb10.tar.gz"
#	 test? (
#		${BASE_TEST_URI}/${MY_P2}_Data_Files_Input.tar.gz
#		${BASE_TEST_URI}/${MY_P2}_Data_Files_Output.tar.gz
#	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

#RDEPEND=""
#DEPEND="test? ( sys-process/time )"

S="${WORKDIR}/${MY_P1}"

src_prepare(){
	rm -rvf Py*
	epatch "${FILESDIR}"/${PV}-Makefile.patch
	cp Makefile_LINUX_gcc42 Makefile

	append-fflags -fno-range-check
	append-cflags -D_USE_XOPEN_EXTENDED

	sed \
		-e "s:^CC.*$:CC = $(tc-getCC):" \
		-e "s:^C++.*$:C++ = $(tc-getCXX):" \
		-e "s:C++:CXX:g" \
		-e "s:^CFLAGS.*$:CFLAGS = ${CFLAGS}:" \
		-e "s:^F90C.*$:F90C = $(tc-getFC):" \
		-e "s:^F90FLAGS.*$:F90FLAGS = ${FFLAGS}:" \
		-e "s:^SOLDFLAGS.*$:SOLDFLAGS = -shared ${LDFLAGS}:g" \
		-e "s: /bin: ${EPREFIX}/bin:g" \
		-e "s:/usr:${EPREFIX}/usr:g" \
		-i Makefile || die
}

src_compile() {
	emake -j1 shared || die
}

# test app is borked in this version
# produces buffer overflows
#src_test(){
#	emake -j1 tests || die
#}

src_install() {
	insinto /usr/include/${PN}
	doins include/* || die

	dolib.so solib/* || die
}

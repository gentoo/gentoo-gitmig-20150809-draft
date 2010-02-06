# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cbflib/cbflib-0.8.1-r5.ebuild,v 1.1 2010/02/06 19:35:10 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

MY_P1="CBFlib-${PV}"
MY_P2="CBFlib_${PV}"

DESCRIPTION="Library providing a simple mechanism for accessing CBF files and imgCIF files."
HOMEPAGE="http://www.bernstein-plus-sons.com/software/CBF/"
#BASE_TEST_URI="http://arcib.dowling.edu/software/CBFlib/downloads/version_${PV}/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P1}.tar.gz"
#	 test? (
#		${BASE_TEST_URI}/${MY_P2}_Data_Files_Input.tar.gz
#		${BASE_TEST_URI}/${MY_P2}_Data_Files_Output.tar.gz
#	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#RDEPEND=""
#DEPEND="test? ( sys-process/time )"

S="${WORKDIR}/${MY_P1}"

src_prepare(){
	cp Makefile_LINUX_gcc42 Makefile

	epatch "${FILESDIR}"/${PV}-Makefile.patch
	epatch "${FILESDIR}"/${PV}-parallel.patch
	epatch "${FILESDIR}"/${PV}-as-needed.patch

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
	emake shared || die
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

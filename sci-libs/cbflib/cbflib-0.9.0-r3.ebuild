# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cbflib/cbflib-0.9.0-r3.ebuild,v 1.5 2011/06/21 15:41:23 jlec Exp $

EAPI="3"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils fortran-2 flag-o-matic toolchain-funcs

PYTHON_MODNAME="pycbf.py"
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
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE="doc python"

DEPEND="virtual/fortran	"
RDEPEND="${DEPEND}"
#test? ( sys-process/time )"

S="${WORKDIR}/${MY_P1}"

src_prepare(){
	rm -rf Py* drel* dRel* ply*
	epatch "${FILESDIR}"/${PV}-Makefile.patch
	edos2unix pycbf/setup.py
	epatch "${FILESDIR}"/${PV}-python.patch
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

	if use python; then
		cd pycbf
		distutils_src_compile
	fi
}

# test app is borked in this version
# produces buffer overflows
#src_test(){
#	emake -j1 tests || die
#}

src_install() {
	insinto /usr/include/${PN}
	doins include/*.h || die

	dolib.so solib/lib* || die

	dodoc README || die
	if use doc; then
		dohtml -r README.html html_graphics doc || die
	fi
	if use python; then
		cd pycbf
		distutils_src_install
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}

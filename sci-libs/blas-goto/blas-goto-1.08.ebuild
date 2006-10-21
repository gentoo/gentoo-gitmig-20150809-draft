# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-goto/blas-goto-1.08.ebuild,v 1.1 2006/10/21 06:15:34 dberkholz Exp $

inherit eutils fortran toolchain-funcs

MY_PN="GotoBLAS"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="The fastest implementations of the Basic Linear Algebra Subroutines"
HOMEPAGE="http://www.tacc.utexas.edu/resources/software/software.php"
SRC_URI="http://www.tacc.utexas.edu/resources/software/login/gotoblas/${MY_P}.tar.gz"
LICENSE="tacc"
SLOT="0"
# See http://www.tacc.utexas.edu/resources/software/gotoblasfaq.php
# for supported architectures
KEYWORDS="~x86"
IUSE="threads"
RESTRICT="mirror"
RDEPEND="app-admin/eselect-blas"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_PN}"
FORTRAN="g77 gfortran" # ifc g95 pgf77 pathf90 f90 f77

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Set up C compiler
	if [[ $(tc-getCC) = *gcc ]]; then
		C_COMPILER="GNU"
	elif [[ $(tc-getCC) = icc ]]; then
		C_COMPILER="INTEL"
	else
		die "tc-getCC() returned an invalid C compiler; valid are gcc or icc."
	fi

	# Set up Fortran compiler
	if [[ ${FORTRANC} = g77 ]]; then
		F_COMPILER="G77"
	elif [[ ${FORTRANC} = gfortran ]]; then
		F_COMPILER="GFORTRAN"
		# Otherwise, we get undefined reference to _gfortran_runtime_error
		FORTRAN_LIB="-lgfortran"
#	elif [[ ${FORTRANC} = ifc ]]; then
#		F_COMPILER="INTEL"
#	elif [[ ${FORTRANC} = g95 ]]; then
#		F_COMPILER="G95"
#	elif [[ ${FORTRANC} = pgf77 ]]; then
#		F_COMPILER="PGI"
#	elif [[ ${FORTRANC} = pathf90 ]]; then
#		F_COMPILER="PATHSCALE"
#	elif [[ ${FORTRANC} = f90 ]] || [[ ${FORTRANC} = f77 ]]; then
#		F_COMPILER="SUN"
#	elif [[ ${FORTRANC} = xlf ]]; then
#		F_COMPILER="IBM"
	else
		die "fortran.eclass returned an invalid Fortran compiler \'${FORTRANC}\'; valid are ${FORTRAN}."
	fi

	# Fix shared lib build
	sed -i \
		-e "s:\(&& echo OK\):${FORTRAN_LIB} \1:g" \
		"${S}"/exports/Makefile

	# Set up compilers
	sed -i \
		-e "s:^\(C_COMPILER =\) GNU:\1 ${C_COMPILER}:g" \
		-e "s:^# \(F_COMPILER =\) G77:\1 ${F_COMPILER}:g" \
		-e "s:^# \(SMP = 1\):\1:g" \
		"${S}"/Makefile.rule

	# Threaded?
	if use threads; then
		sed -i \
			-e "s:^# \(SMP = 1\):\1:g" \
			"${S}"/Makefile.rule
	fi

	# If you need a 64-bit binary
	# If you need a 64-bit integer interface, also do this for "INTERFACE64 = 1"
	if use amd64; then
		sed -i \
			-e "s:^# \(BINARY64  = 1\):\1:g" \
			"${S}"/Makefile.rule
	fi

	# Respect CFLAGS/FFLAGS
	sed -i \
		-e "/^COMMON_OPT +=  -O2$/d" \
		"${S}"/Makefile.rule
	sed -i \
		-e "s:^\(CCOMMON_OPT +=\)$:\1 ${CFLAGS}:g" \
		-e "s:^\(FCOMMON_OPT +=\)$:\1 ${FFLAGS:- -O2}:g" \
		"${S}"/Makefile.rule
}

src_compile() {
	# Make static library
	emake || die "emake failed"

	# Make shared library
	cd exports
	emake so -j1 || die "emake failed"
}

src_install() {
	local MAIN_DIR="/usr/$(get_libdir)/blas"
	local DIR="${MAIN_DIR}/goto"

	# dolib.so doesn't support our alternate locations
	exeinto ${DIR}
	doexe libgoto_*.so
	dosym libgoto_*.so ${DIR}/libgoto.so
	dosym libgoto_*.so ${DIR}/libgoto.so.0
	dosym libgoto_*.so ${DIR}/libgoto.so.0.0.0

	# dolib.a doesn't support our alternate locations
	insinto ${DIR}
	doins libgoto_*.a
	dosym libgoto_*.a ${DIR}/libgoto.a

	eselect blas add $(get_libdir) "${FILESDIR}"/eselect-goto goto
}

pkg_postinst() {
	if [[ -z $(eselect blas show) ]]; then
		eselect blas set goto
	fi
}

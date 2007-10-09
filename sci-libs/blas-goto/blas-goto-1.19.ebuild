# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-goto/blas-goto-1.19.ebuild,v 1.3 2007/10/09 22:08:56 bicatali Exp $

inherit eutils fortran flag-o-matic toolchain-funcs

MY_PN="GotoBLAS"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="The fastest implementations of the Basic Linear Algebra Subroutines"
HOMEPAGE="http://www.tacc.utexas.edu/resources/software/software.php"
SRC_URI="http://www.tacc.utexas.edu/resources/software/login/gotoblas/${MY_P}.tar.gz"
LICENSE="tacc"
SLOT="0"
# See http://www.tacc.utexas.edu/resources/software/gotoblasfaq.php
# for supported architectures
KEYWORDS="~x86 ~amd64"
IUSE="threads doc"
RESTRICT="mirror"
RDEPEND="app-admin/eselect-blas
	dev-util/pkgconfig
	doc? ( app-doc/blas-docs )"

DEPEND="app-admin/eselect-blas
	>=sys-devel/binutils-2.17"

S="${WORKDIR}/${MY_PN}"
FORTRAN="g77 gfortran ifc"

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

	# Set up FORTRAN 77 compiler
	case ${FORTRANC} in
		g77)
			F_COMPILER="G77"
			;;
		gfortran)
			F_COMPILER="GFORTRAN"
			F_LIB="-lgfortran"
			;;
		ifc|ifort)
			F_COMPILER="INTEL"
			;;
		*)
		die "fortran.eclass returned an invalid Fortran compiler \'${FORTRANC}\'; valid are ${FORTRAN}."
	esac

	# Fix shared lib build
	sed -i \
		-e "s:\(&& echo OK\):${F_LIB} \1:g" \
		"${S}"/exports/Makefile \
		|| die "sed for shared libs failed"

	# Set up compilers
	sed -i \
		-e "s:^# \(C_COMPILER =\) GNU:\1 ${C_COMPILER}:g" \
		-e "s:^# \(F_COMPILER =\) G77:\1 ${F_COMPILER}:g" \
		-e "s:^# \(SMP = 1\):\1:g" \
		-e "s:\$(COMPILER_PREFIX)ar:$(tc-getAR):" \
		-e "s:\$(COMPILER_PREFIX)as:$(tc-getAS):" \
		-e "s:\$(COMPILER_PREFIX)ld:$(tc-getLD):" \
		-e "s:\$(COMPILER_PREFIX)ranlib:$(tc-getRANLIB):" \
		"${S}"/Makefile.rule \
		|| die "sed for setting up compilers failed"

	# Threaded?
	if use threads; then
		sed -i \
			-e "s:^# \(SMP = 1\):\1:g" \
			"${S}"/Makefile.rule \
			|| die "sed for threads failed"
	fi

	# If you need a 64-bit integer interface, also do this for "INTERFACE64 = 1"
	if use amd64; then
		sed -i \
			-e "s:^# \(BINARY64  = 1\):\1:g" \
			"${S}"/Makefile.rule \
			|| die "sed for 64 binary failed"
	fi

	# Respect CFLAGS/FFLAGS
	if [[ -z "${FFLAGS}" ]]; then
		ewarn "FORTRAN FFLAGS undefined, using -O2"
		export FFLAGS="-O2"
	fi

	sed -i \
		-e '/^CFLAGS/s:=:+=:' \
		-e '/^FFLAGS/s:=:+=:' \
		"${S}"/Makefile.rule \
		|| die "sed for flags failed"
}

src_compile() {

	# Make static library
	emake LDFLAGS="$(raw-ldflags)" || die "emake failed"

	# Make shared library
	cd exports
	emake so -j1 || die "emake failed"
}

src_test() {
	cd test
	emake || die "emake test failed"
	make clean
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

	dodoc 01Readme.txt 03History.txt 04FAQ.txt

	cp "${FILESDIR}"/blas.pc.in blas.pc
	local extlibs=""
	use threads && extlibs="${extlibs} -lpthread"
	extlibs="${extlibs}"
	sed -i \
		-e "s/@LIBDIR@/$(get_libdir)/" \
		-e "s/@PV@/${PV}/" \
		-e "s/@EXTLIBS@/${extlibs}/" \
		blas.pc || die "sed blas.pc failed"
	insinto /usr/$(get_libdir)/blas/goto
	doins blas.pc
	ESELECT_PROF=goto
	eselect blas add $(get_libdir) "${FILESDIR}"/eselect.blas.goto ${ESELECT_PROF}
}

pkg_postinst() {
	local p=blas
	local current_lib=$(eselect ${p} show | cut -d' ' -f2)
	if [[ ${current_lib} == ${ESELECT_PROF} || -z ${current_lib} ]]; then
		# work around eselect bug #189942
		local configfile="${ROOT}"/etc/env.d/${p}/lib/config
		[[ -e ${configfile} ]] && rm -f ${configfile}
		eselect ${p} set ${ESELECT_PROF}
		elog "${p} has been eselected to ${ESELECT_PROF}"
	else
		elog "Current eselected ${p} is ${current_lib}"
		elog "To use ${p} ${ESELECT_PROF} implementation, you have to issue (as root):"
		elog "\t eselect ${p} set ${ESELECT_PROF}"
	fi
}

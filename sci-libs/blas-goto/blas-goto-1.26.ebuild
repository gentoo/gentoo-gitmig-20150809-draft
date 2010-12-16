# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-goto/blas-goto-1.26.ebuild,v 1.3 2010/12/16 14:24:01 jlec Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_PN="GotoBLAS"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Fast implementations of the Basic Linear Algebra Subroutines"
HOMEPAGE="http://www.tacc.utexas.edu/research-development/tacc-projects/"
SRC_URI="http://www-prc.tacc.utexas.edu/resources/software/login/gotoblas/${MY_P}.tar.gz"
LICENSE="tacc"
SLOT="0"
# See http://www.tacc.utexas.edu/resources/software/gotoblasfaq.php
# for supported architectures
KEYWORDS="~x86 ~amd64"
IUSE="int64 threads doc"
RESTRICT="mirror"

RDEPEND="app-admin/eselect-blas
	doc? ( app-doc/blas-docs )"
DEPEND="app-admin/eselect-blas
	>=sys-devel/binutils-2.17"

S="${WORKDIR}/${MY_PN}"

ESELECT_PROF=goto

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch to link with m and fortran libs, works with asneeded
	epatch "${FILESDIR}"/${P}-sharedlibs.patch

	# Set up C compiler: forcing gcc for now
	if [[ $(tc-getCC) != *gcc ]]; then
		ewarn "Your C compiler is set to $(tc-getCC)"
		ewarn "${PN} needs gcc to inline assembler, others compilers have reported failures"
		ewarn "Forcing gcc"
	fi
	C_COMPILER=GNU

	# Set up FORTRAN 77 compiler
	case $(tc-getFC) in
		g77) F_COMPILER=G77;;
		gfortran) F_COMPILER=GFORTRAN;;
		ifc|ifort) F_COMPILER=INTEL;;
		*)
			die "Invalid Fortran compiler: $(tc-getFC); valid are ${FORTRAN}."
	esac

	# Set up compilers
	sed -i \
		-e "s:^# \(C_COMPILER =\) GNU:\1 ${C_COMPILER}:g" \
		-e "s:^# \(F_COMPILER =\) G77:\1 ${F_COMPILER}:g" \
		-e "s:\$(CROSS_BINUTILS)ar:$(tc-getAR):" \
		-e "s:\$(CROSS_BINUTILS)as:$(tc-getAS):" \
		-e "s:\$(CROSS_BINUTILS)ld:$(tc-getLD):" \
		-e "s:\$(CROSS_BINUTILS)ranlib:$(tc-getRANLIB):" \
		Makefile.rule \
		|| die "sed for toolchain failed"

	if use threads; then
		sed -i \
			-e "s:^# \(SMP = 1\):\1:g" \
			Makefile.rule \
			|| die "sed for threads failed"
	fi

	if use amd64; then
		sed -i \
			-e "s:^# \(BINARY64  = 1\):\1:g" \
			Makefile.rule \
			|| die "sed for 64 binary failed"
	fi

	if use int64; then
		sed -i \
			-e "s:^# \(INTERFACE64  = 1\):\1:g" \
			Makefile.rule \
			|| die "sed for 64 integers failed"
		ESELECT_PROF="${ESELECT_PROF}-int64"
	fi
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
	local install_dir=/usr/$(get_libdir)/blas/goto
	dodir ${install_dir}

	# dolib.so doesn't support our alternate locations
	exeinto ${install_dir}
	doexe libgoto_*.so || die "installing shared lib failed"
	dosym libgoto_*.so ${install_dir}/libgoto.so
	dosym libgoto_*.so ${install_dir}/libgoto.so.0
	dosym libgoto_*.so ${install_dir}/libgoto.so.0.0.0

	# dolib.a doesn't support our alternate locations
	insinto ${install_dir}
	doins libgoto_*.a || die "installing static lib failed"
	dosym libgoto_*.a ${install_dir}/libgoto.a

	dodoc 01Readme.txt 03History.txt 04FAQ.txt || die

	cp "${FILESDIR}"/blas.pc.in blas.pc
	local extlibs=""
	use threads && extlibs="${extlibs} -lpthread"
	sed -i \
		-e "s/@LIBDIR@/$(get_libdir)/" \
		-e "s/@PV@/${PV}/" \
		-e "s/@EXTLIBS@/${extlibs}/" \
		blas.pc || die "sed blas.pc failed"
	insinto /usr/$(get_libdir)/blas/goto
	doins blas.pc
	eselect blas add $(get_libdir) "${FILESDIR}"/eselect.blas.goto ${ESELECT_PROF}
}

pkg_postinst() {
	local p=blas
	local current_lib=$(eselect ${p} show | cut -d' ' -f2)
	if [[ ${current_lib} == ${ESELECT_PROF} || -z ${current_lib} ]]; then
		# work around eselect bug #189942
		local configfile="${ROOT}"/etc/env.d/${p}/$(get_libdir)/config
		[[ -e ${configfile} ]] && rm -f ${configfile}
		eselect ${p} set ${ESELECT_PROF}
		elog "${p} has been eselected to ${ESELECT_PROF}"
	else
		elog "Current eselected ${p} is ${current_lib}"
		elog "To use ${p} ${ESELECT_PROF} implementation, you have to issue (as root):"
		elog "\t eselect ${p} set ${ESELECT_PROF}"
	fi
}

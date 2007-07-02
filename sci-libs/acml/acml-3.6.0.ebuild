# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/acml/acml-3.6.0.ebuild,v 1.2 2007/07/02 15:25:55 peper Exp $

inherit eutils toolchain-funcs fortran

DESCRIPTION="AMD Core Math Library (ACML) for x86 and amd64 CPUs"
HOMEPAGE="http://developer.amd.com/acml.jsp"

MY_PV=${PV//\./\-}
S=${WORKDIR}

SRC_URI="amd64? ( ifc? ( acml-${MY_PV}-ifort-64bit.tgz )
				!ifc? ( acml-${MY_PV}-gnu-64bit.tgz ) )
	x86? ( ifc? ( acml-${MY_PV}-ifort-32bit.tgz )
		!ifc? ( acml-${MY_PV}-gnu-32bit.tgz ) )"

RESTRICT="fetch strip"
IUSE="ifc openmp doc examples"
LICENSE="ACML"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="app-admin/eselect-blas
	app-admin/eselect-cblas
	app-admin/eselect-lapack"

DEPEND="${RDEPEND}"

PROVIDE="virtual/blas
	virtual/lapack"

pkg_nofetch() {
	einfo "Please download the ACML from:"
	einfo "${HOMEPAGE}"
	einfo "and place it in ${DISTDIR}"
	einfo "The previous versions could be found at"
	einfo "http://developer.amd.com/acmlarchive.jsp"
}

pkg_setup() {
	if use openmp && ! use ifc; then
		eerror "Multi-processors ACML not available for g77 compiler"
		eerror "Please either unset openmp USE flag, choose ifc or update acml"
		die "setup openmp failed"
	fi
	elog "From version 3.5.0 on, ACML no longer supports"
	elog "hardware without SSE/SSE2 instructions. "
	elog "For older 32-bit hardware that does not support SSE/SSE2,"
	elog "you must continue to use an older version (ACML 3.1.0 and ealier)."
	epause
	FORTRAN="g77"
	use ifc && FORTRAN="ifc"
	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	(DISTDIR="${S}" unpack contents-acml-*.tgz)
	local fort
	case ${FORTRANC} in
		g77)
			fort=gnu
			;;
		ifc|ifort)
			fort=ifort
			;;
		*)
			eerror "Unsupported fortran compiler: $FORTRANC"
			die
			;;
	esac
	local bits="32"
	use amd64 && bits="64"
	ACMLDIR=${S}/${fort}${bits}
	use openmp && ACMLDIR="${ACMLDIR} ${ACMLDIR}_smp"
}

src_compile() {
	einfo "Nothing to compile"
	return
}

src_test() {
	for f in ${ACMLDIR}; do
		einfo "Testing acml for $(basename ${f})"
		for d in . acml_mv; do
			cd "${f}/examples/${d}"
			emake \
				ACMLDIR="${f}" \
				F77="${FORTRANC}" \
				CC="$(tc-getCC)" \
				CPLUSPLUS="$(tc-getCXX)" \
				|| die "emake test in ${d} failed"
			emake clean
		done
	done
}

src_install() {
	# Libraries
	for f in ${ACMLDIR}; do
		dolib ${f}/lib/* || die "dolib failed"
	done

	# Headers (same openmp or not)
	insinto /usr/include/acml
	doins ${f}*/include/* || die "doins headers failed"
	dosym acml/acml.h /usr/include/acml.h

	# Documentation
	dodoc ReleaseNotes*
	cd ${S}/Doc
	dodoc *.txt
	doinfo *info*
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins acml.pdf
		dohtml html/*
	fi
	if use examples; then
		for f in ${ACMLDIR}; do
			insinto "/usr/share/doc/${PF}/examples/$(basename ${f})"
			doins -r ${f}/examples/*
		done
	fi

	# eselect files
	for l in blas cblas lapack; do
		eselect ${l} add $(get_libdir) "${FILESDIR}"/eselect.${l} acml
		use openmp && eselect ${l} add $(get_libdir) "${FILESDIR}"/eselect.${l}-mp acml-mp
	done
}

pkg_postinst() {
	# set acml if none are set yet
	for l in blas cblas lapack; do
		if [[ -z "$(eselect ${l} show)" ]]; then
			if use openmp; then
				eselect ${l} set acml-mp
			else
				eselect ${l} set acml
			fi
		fi
		elog "To use ACML's BLAS features, you have to issue (as root):"
		elog "\n\teselect ${l} set acml # or acml-mp for multi-processors\n"
	done
}

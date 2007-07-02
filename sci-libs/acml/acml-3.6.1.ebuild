# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/acml/acml-3.6.1.ebuild,v 1.2 2007/07/02 15:25:55 peper Exp $

inherit eutils toolchain-funcs fortran

DESCRIPTION="AMD Core Math Library (ACML) for x86 and amd64 CPUs"
HOMEPAGE="http://developer.amd.com/acml.jsp"

MY_PV=${PV//\./\-}
S=${WORKDIR}
SRC_URI="x86? ( acml-${MY_PV}-gfortran-32bit.tgz )
	amd64? ( int64? ( acml-${MY_PV}-gfortran-64bit-int64.tgz )
		!int64? ( acml-${MY_PV}-gfortran-64bit.tgz ) )"

RESTRICT="fetch strip"
IUSE="int64 doc examples"
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
	elog "From version 3.5.0 on, ACML no longer supports"
	elog "hardware without SSE/SSE2 instructions. "
	elog "For older 32-bit hardware that does not support SSE/SSE2,"
	elog "you must continue to use an older version (ACML 3.1.0 and ealier)."
	epause
	FORTRAN="gfortran"
	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	(DISTDIR="${S}" unpack contents-acml-*.tgz)
	local bits="32"
	use amd64 && bits="64"
	local i64=""
	use int64 && i64="_int64"
	ACMLDIR=${S}/${FORTRANC}${bits}${i64}
}

src_compile() {
	einfo "Nothing to compile"
	return
}

src_test() {
	einfo "Testing acml"
	for d in . acml_mv; do
		cd "${ACMLDIR}/examples/${d}"
		emake \
			ACMLDIR="${ACMLDIR}" \
			F77="${FORTRANC}" \
			CC="$(tc-getCC)" \
			CPLUSPLUS="$(tc-getCXX)" \
			|| die "emake test in ${d} failed"
		emake clean
	done
}

src_install() {
	# Libraries
	dolib ${ACMLDIR}/lib/* || die "dolib failed"

	# Headers
	insinto /usr/include/acml
	doins ${ACMLDIR}/include/* || die "doins headers failed"
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
	use examples && doins -r ${ACMLDIR}/examples

	# eselect files
	for l in blas cblas lapack; do
		eselect ${l} add $(get_libdir) "${FILESDIR}"/eselect.${l} acml
	done
}

pkg_postinst() {
	# set acml if none are set yet
	for l in blas cblas lapack; do
		[[ -z "$(eselect ${l} show)" ]] && eselect ${l} set acml
		elog "To use ACML's BLAS features, you have to issue (as root):"
		elog "\n\teselect ${l} set acml # or acml-mp for multi-processors\n"
	done
}

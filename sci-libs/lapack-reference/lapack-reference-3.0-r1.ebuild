# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-reference/lapack-reference-3.0-r1.ebuild,v 1.3 2007/01/23 13:46:09 markusle Exp $

inherit eutils fortran

MyPN="${PN/-reference/}"

DESCRIPTION="FORTRAN reference implementation of LAPACK Linear Algebra PACKage"
LICENSE="lapack"
HOMEPAGE="http://www.netlib.org/lapack/index.html"
SRC_URI="http://www.netlib.org/lapack/${MyPN}-${PV}.tgz
	mirror://gentoo/${MyPN}-20020531-20021004.patch.bz2
	mirror://gentoo/${MyPN}-gentoo.patch"

SLOT="0"
IUSE="ifc"
KEYWORDS="amd64 x86"

DEPEND="sys-devel/libtool
	sci-libs/lapack-config
	ifc? ( dev-lang/ifc )"

RDEPEND="virtual/blas
	ifc? ( dev-lang/ifc )" # Need ifc runtime libraries

PROVIDE="virtual/lapack"

FORTRAN="g77 ifc"

S="${WORKDIR}/LAPACK"

ifc_info() {
	if [ -z "${IFCFLAGS}" ]
	then
		einfo
		einfo "You may want to set some ifc optimization flags by running this"
		einfo "ebuild as, for example, \`IFCFLAGS=\"-O3 -tpp7 -xW\" emerge blas\`"
		einfo "(Pentium 4 exclusive optimizations)."
		einfo
		einfo "ifc defaults to -O2, with code tuned for Pentium 4, but that"
		einfo "will run on any processor."
		einfo
		einfo "Beware that ifc's -O3 is very aggressive, sometimes resulting in"
		einfo "significantly worse performance."
		einfo
		epause 5
	fi
}

src_unpack() {
	unpack ${A}
	epatch "${DISTDIR}"/lapack-20020531-20021004.patch.bz2
	epatch "${DISTDIR}"/lapack-gentoo.patch
}

src_compile() {
	TOP_PATH="${DESTTREE}"/lib/lapack
	# Library will be installed in RPATH:
	RPATH="${TOP_PATH}"/reference

	if use ifc; then
		FC="ifc"
		FFLAGS="${IFCFLAGS}"
		NOOPT="-O0" # Do NOT change this. It is applied to two files with
					# routines to determine machine constants.
		ifc_info
	else
		FC="g77"
		FFLAGS="${CFLAGS}"
		NOOPT=""
		# libg2c is required to link with liblapack.so using ifc:
		DEP_LIBS="-lg2c"
	fi

	DEP_LIBS="${DEP_LIBS} -lblas"

	cd "${S}"/SRC
	make all FORTRAN="libtool --mode=compile --tag=F77 ${FC}" OPTS="${FFLAGS}"\
		NOOPT="${NOOPT}" || die

	if use ifc; then
		# Intel portability library that provides the etime function
		${FC} -shared ${FFLAGS} *.lo ${DEP_LIBS} -Wl,-soname \
			-Wl,liblapack.so.0 -o liblapack.so.0.0.0 -Vaxlib || die
		ar cru liblapack.a *.o || die
		ranlib liblapack.a || die
	else
		libtool --mode=link --tag=CC ${FC} ${FFLAGS} -o liblapack.la *.lo \
			-rpath ${RPATH} ${DEP_LIBS} || die
	fi
}

src_install() {
	dodir "${RPATH}" || die

	cd "${S}"/SRC

	if use ifc;	then
		strip --strip-unneeded liblapack.so.0.0.0 || die
		strip --strip-debug liblapack.a || die

		exeinto "${RPATH}"
		doexe liblapack.so.0.0.0 || die
		dosym liblapack.so.0.0.0 ${RPATH}/liblapack.so.0 || die
		dosym liblapack.so.0.0.0 ${RPATH}/liblapack.so || die

		insinto "${RPATH}"
		doins liblapack.a || die
	else
		libtool --mode=install install -s liblapack.la "${D}/${RPATH}" || die
	fi

	insinto ${TOP_PATH}
	doins "${FILESDIR}"/f77-reference || die

	dodoc "${S}"/README
}

pkg_postinst() {
	"${DESTTREE}"/bin/lapack-config reference
}

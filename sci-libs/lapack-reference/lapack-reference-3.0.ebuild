# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-reference/lapack-reference-3.0.ebuild,v 1.5 2007/01/23 13:46:09 markusle Exp $

inherit eutils

MyPN=${PN/-reference/}

DESCRIPTION="FORTRAN reference implementation of LAPACK Linear Algebra PACKage"
HOMEPAGE="http://www.netlib.org/lapack/index.html"
SRC_URI="http://www.netlib.org/lapack/${MyPN}-${PV}.tgz
	mirror://gentoo/${MyPN}-20020531-20021004.patch.bz2
	mirror://gentoo/${MyPN}-gentoo.patch"

LICENSE="lapack"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="ifc"

DEPEND="sys-devel/libtool
	sci-libs/lapack-config
	ifc? ( dev-lang/ifc )"

RDEPEND="virtual/blas
	ifc? ( dev-lang/ifc )" # Need ifc runtime libraries

PROVIDE="virtual/lapack"

S=${WORKDIR}/LAPACK

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

pkg_setup() {
	# This version of lapack *can* be build completely with ifc
	use ifc || \
	if [ -z `which g77` ]; then
		eerror "g77 not found on the system!"
		eerror "Please add fortran to your USE flags and reemerge gcc!"
		die
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/lapack-20020531-20021004.patch.bz2
	epatch ${DISTDIR}/lapack-gentoo.patch
}

src_compile() {
	TOP_PATH=${DESTTREE}/lib/lapack
	# Library will be installed in RPATH:
	RPATH=${TOP_PATH}/reference

	if use ifc
	then
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

	cd ${S}/SRC
	make all \
		FORTRAN="libtool --mode=compile --tag=F77 ${FC}"\
		OPTS="${FFLAGS}"\
		NOOPT="${NOOPT}" \
		|| die

	if use ifc
	then
		${FC} -shared ${FFLAGS} *.lo ${DEP_LIBS} \
			-Wl,-soname -Wl,liblapack.so.0 -o liblapack.so.0.0.0 \
			-Vaxlib # Intel portability library that provides the etime function
		ar cru liblapack.a *.o
		ranlib liblapack.a
	else
		libtool --mode=link --tag=CC ${FC} ${FFLAGS} -o liblapack.la *.lo \
			-rpath ${RPATH} ${DEP_LIBS}
	fi
}

src_install() {
	dodir ${RPATH}

	cd ${S}/SRC

	if use ifc
	then
		strip --strip-unneeded liblapack.so.0.0.0
		strip --strip-debug liblapack.a

		exeinto ${RPATH}
		doexe liblapack.so.0.0.0
		dosym liblapack.so.0.0.0 ${RPATH}/liblapack.so.0
		dosym liblapack.so.0.0.0 ${RPATH}/liblapack.so

		insinto ${RPATH}
		doins liblapack.a
	else
		libtool --mode=install install -s liblapack.la ${D}/${RPATH}
	fi

	insinto ${TOP_PATH}
	doins ${FILESDIR}/f77-reference

	dodoc ${S}/README
}

pkg_postinst() {
	${DESTTREE}/bin/lapack-config reference
}

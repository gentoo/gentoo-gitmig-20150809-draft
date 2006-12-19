# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-atlas/lapack-atlas-3.7.24.ebuild,v 1.1 2006/12/19 23:11:56 markusle Exp $

inherit eutils flag-o-matic toolchain-funcs fortran

DESCRIPTION="Full LAPACK implementation using available ATLAS routines"
LICENSE="BSD"
HOMEPAGE="http://math-atlas.sourceforge.net/"
MY_PN="${PN/lapack-/}"
SRC_URI1="mirror://sourceforge/math-atlas/${MY_PN}${PV}.tar.bz2"
SRC_URI2="http://www.netlib.org/lapack/lapack.tgz"
SRC_URI="${SRC_URI1} ${SRC_URI2}
	mirror://gentoo/lapack-20020531-20021004.patch.bz2
	mirror://gentoo/${MY_PN}-3.7.23-shared-libs.patch.bz2"

SLOT="0"
IUSE="doc"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="virtual/blas
	app-admin/eselect-lapack"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5
	~sci-libs/blas-atlas-3.7.24"

PROVIDE="virtual/lapack"

FORTRAN="g77 gfortran"

S="${WORKDIR}/ATLAS"
S_LAPACK="${WORKDIR}/LAPACK"
BLD_DIR="${S}/gentoo-build"
RPATH="${DESTTREE}/$(get_libdir)/lapack/atlas"

pkg_setup() {
	fortran_pkg_setup
	echo
	ewarn "Please make sure to disable CPU throttling completely"
	ewarn "during the compile of lapack-atlas. Otherwise, all atlas"
	ewarn "generated timings will be completely random and the"
	ewarn "performance of the resulting libraries will be degraded"
	ewarn "considerably."
	echo
	epause 8
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	epatch "${DISTDIR}"/${MY_PN}-3.7.23-shared-libs.patch.bz2
	epatch "${FILESDIR}"/${MY_PN}-asm-gentoo.patch
	epatch "${DISTDIR}"/lapack-20020531-20021004.patch.bz2
	epatch "${FILESDIR}"/lapack-reference-3.0-autotool.patch

	cd "${S}"
	mkdir ${BLD_DIR}  || die "failed to generate build directory"
	cp "${FILESDIR}"/war "${BLD_DIR}" && chmod a+x "${BLD_DIR}"/war \
		|| die "failed to install war"

	# make sure the compile picks up the proper includes
	sed -e 's|INCLUDES =|INCLUDES = -I/usr/include/atlas/|'  \
		-i CONFIG/src/SpewMakeInc.c || \
		die "failed to append proper includes"

	# force proper 32/64bit libs
	local archselect
	if [[ "${ARCH}" == "amd64" || "${ARCH}" == "ppc64" ]]; then
		archselect="-b 64"
	else
		archselect="-b 32"
	fi

	# set up compiler/flags using atlas' native configure
	local compdefs
	compdefs="${compdefs} -C xc '$(tc-getCC)' -F xc '${CFLAGS}'"
	compdefs="${compdefs} -C ic '$(tc-getCC)' -F ic '${CFLAGS}'"
	compdefs="${compdefs} -C sk '$(tc-getCC)' -F sk '${CFLAGS}'"
	compdefs="${compdefs} -C dk '$(tc-getCC)' -F dk '${CFLAGS}'"
	compdefs="${compdefs} -C sm '$(tc-getCC)' -F sm '${CFLAGS}'"
	compdefs="${compdefs} -C dm '$(tc-getCC)' -F dm '${CFLAGS}'"
	compdefs="${compdefs} -C if '${FORTRANC}' -F if '${FFLAGS}'"
	compdefs="${compdefs} -Si cputhrchk 0 ${archselect}"


	cd ${BLD_DIR} && ../configure ${compdefs} \
		|| die "configure failed"

	cd "${S_LAPACK}"
	eautoreconf
}

src_compile() {
	# build atlas' part of lapack
	cd "${BLD_DIR}"/src/lapack
	make lib || die "Failed to make lib in ${BLD_DIR}/src/lapack"

	cd "${BLD_DIR}"/interfaces/lapack/C/src
	make lib || die "Failed to make lib in ${BLD_DIR}/interfaces/lapack/C/src"

	cd "${BLD_DIR}"/interfaces/lapack/F77/src
	make lib || die "Failed to make lib in ${BLD_DIR}/interfaces/lapack/F77/src"

	# build rest of lapack
	cd "${S_LAPACK}"
	econf || die "Failed to configure reference lapack lib"
	emake || die "Failed to make reference lapack lib"

	cd "${S_LAPACK}"/SRC
	einfo "Copying liblapack.a/*.o to ${S_LAPACK}/SRC"
	cp -sf "${BLD_DIR}"/gentoo/liblapack.a/*.o .
	einfo "Copying liblapack.a/*.lo to ${S_LAPACK}/SRC"
	cp -sf "${BLD_DIR}"/gentoo/liblapack.a/*.lo .
	einfo "Copying liblapack.a/.libs/*.o to ${S_LAPACK}/SRC"
	cp -sf "${BLD_DIR}"/gentoo/liblapack.a/.libs/*.o .libs/

	# make sure shared libs link against proper libraries
	if [[ ${FORTRANC} == "gfortran" ]]; then
		libs="${LDFLAGS} -lpthread -lgfortran"
	else
		libs="${LDFLAGS} -lpthread -lg2c"
	fi

	../libtool --mode=link --tag=F77 ${FORTRANC} -lblas -lcblas \
		-latlas ${libs} -o liblapack.la *.lo -rpath "${RPATH}" \
		|| die "Failed to create liblapack.la"
}

src_install () {
	dodir "${RPATH}"

	cd "${S_LAPACK}"/SRC
	../libtool --mode=install install -s liblapack.la \
		"${D}/${RPATH}" \
		|| die "Failed to install lapack-atlas library"

	eselect lapack add $(get_libdir) ${FILESDIR}/eselect.lapack atlas

	insinto /usr/include/atlas
	cd "${S}"/include
	doins clapack.h || die "Failed to install clapack.h"

	cd "${S}"
	dodoc README doc/AtlasCredits.txt doc/ChangeLog || \
		die "Failed to install docs"
	if use doc; then
		dodoc doc/lapackqref.ps || die "Failed to install docs"
	fi
}

pkg_postinst() {
	if [[ -z "$(eselect lapack show)" ]]; then
		eselect lapack set atlas
	fi

	elog
	elog "To link with ATLAS LAPACK from C or Fortran, simply use:"
	elog
	elog "-llapack"
	elog
	elog "C users: your header is /usr/include/atlas/clapack.h"
	elog
	elog "Configuration now uses eselect rather than lapack-config."
}

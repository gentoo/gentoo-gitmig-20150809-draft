# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-atlas/lapack-atlas-3.7.11-r1.ebuild,v 1.4 2006/08/17 18:25:12 dberkholz Exp $

inherit eutils flag-o-matic toolchain-funcs fortran

DESCRIPTION="Full LAPACK implementation using available ATLAS routines"
LICENSE="BSD"
HOMEPAGE="http://math-atlas.sourceforge.net/"
MY_PN="${PN/lapack-/}"
SRC_URI1="mirror://sourceforge/math-atlas/${MY_PN}${PV}.tar.bz2"
SRC_URI2="http://www.netlib.org/lapack/lapack.tgz"
SRC_URI="${SRC_URI1} ${SRC_URI2}
	mirror://gentoo/lapack-20020531-20021004.patch.bz2
	mirror://gentoo/lapack-gentoo.patch
	mirror://gentoo/${MY_PN}3.6.0-shared-libs.3.patch.bz2"

SLOT="0"
IUSE="ifc doc"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="virtual/libc
	app-admin/eselect-lapack
	virtual/blas
	ifc? ( dev-lang/ifc )" # Need Intel runtime libraries

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5
	~sci-libs/blas-atlas-3.7.11"

PROVIDE="virtual/lapack"

FORTRAN="g77 gfortran ifc"

S="${WORKDIR}/ATLAS"
S_LAPACK="${WORKDIR}/LAPACK"

TOP_PATH="${DESTTREE}/$(get_libdir)/lapack"
# Path where libraries will be installed:
RPATH="${TOP_PATH}/atlas"

ifc_info() {
	if [ -z "${IFCFLAGS}" ]
	then
		elog
		elog "You may want to set some ifc optimization flags by running this"
		elog "ebuild as, for example:"
		elog
		elog "IFCFLAGS=\"-O3 -tpp7 -xW\" emerge lapack-atlas"
		elog "(Pentium 4 exclusive optimizations)."
		elog
		elog "ifc defaults to -O2, with code tuned for Pentium 4, but that"
		elog "will run on any processor."
		elog
		elog "Beware that ifc's -O3 is very aggressive, sometimes resulting in"
		elog "significantly worse performance."
		elog
	fi
}

src_unpack() {
	use ifc && ifc_info
	unpack ${A}

	cd "${WORKDIR}"
	epatch "${FILESDIR}"/unbuffered.patch
	epatch "${FILESDIR}"/${PV}-allow-any-gcc-version.patch
	epatch "${DISTDIR}"/atlas3.6.0-shared-libs.3.patch.bz2
	epatch "${DISTDIR}"/lapack-20020531-20021004.patch.bz2
	epatch "${DISTDIR}"/lapack-gentoo.patch
	cp "${FILESDIR}"/war "${S}"
	chmod a+x "${S}"/war

	einfo "Making ${PN} respect compiler settings"
	sed -i \
		-e "s:\(\t./xconfig\):\1 -m $(tc-getCC) -c $(tc-getCC) -f ${FORTRANC}:g" \
		${S}/Makefile \
		|| die "Failed to fix compilers"

	if [[ $(gcc-major-version) -ge 4 ]]; then
		einfo "Updating Makefiles for gcc-4"
		sed -i \
			-e "s:g2c:gfortran:g" \
			${S}/Make.top \
			${S}/makes/Make.lib \
			|| die "Failed to update for gcc-4"
	fi

	# make sure shared libs link against proper libraries
	if [[ ${FORTRANC} == "gfortran" ]]; then
		libs="-lpthread -lgfortran"
	else
		libs="-lpthread -lg2c"
	fi
	sed -e "s/SHRD_LNK/${libs}/g" -i ${S}/Make.top || \
	die "Failed to add addtional libs to shared object build"
}

atlas_fail() {
	eerror
	eerror "ATLAS auto-config failed."
	eerror "Please run 'interactive=1 emerge lapack-atlas' to configure"
	eerror "manually."
	eerror
	die "ATLAS auto-config failed."
}

src_compile() {
	cd "${S}"
	if [ -n "${interactive}" ]; then
		echo "${interactive}"
		make config CC="$(tc-getCC) -DUSE_LIBTOOL -DINTERACTIVE" || die
	else
		# Use ATLAS defaults for all questions:
		(echo | make config CC="$(tc-getCC) -DUSE_LIBTOOL") || atlas_fail
	fi

	TMPSTR=$(ls Make.Linux*)
	ATLAS_ARCH=${TMPSTR#'Make.'}

	GENTOO_CC="libtool --mode=compile --tag=CC $(tc-getCC) -I/usr/include/atlas"

	cd "${S}"/src/lapack/${ATLAS_ARCH}
	make lib CC="${GENTOO_CC}" \
		|| die "Failed to make lib in ${S}/src/lapack/${ATLAS_ARCH}"

	cd "${S}"/interfaces/lapack/C/src/${ATLAS_ARCH}
	make lib CC="${GENTOO_CC}" \
		|| die "Failed to make lib in ${S}/interfaces/lapack/C/src/${ATLAS_ARCH}"

	cd "${S}"/interfaces/lapack/F77/src/${ATLAS_ARCH}

	make lib CC="${GENTOO_CC}" F77="libtool --mode=compile --tag=F77 ${FORTRANC}" \
		|| die "Failed to make lib in ${S}/interfaces/lapack/F77/src/${ATLAS_ARCH}"

	cd "${S_LAPACK}"
	if use ifc; then
		FFLAGS="${IFCFLAGS}"
		NOOPT="-O0" # Do NOT change this. It is applied to two files with
					# routines to determine machine constants.
	else
		# g77 hates opts, esp. machine-specific
		ALLOWED_FLAGS="-O -O1 -O2 -fstack-protector -fno-unit-at-a-time \
						-pipe -g -Wall"
		strip-flags
		FFLAGS="${CFLAGS}"
		NOOPT=""
	fi
	make lapacklib FORTRAN="libtool --mode=compile --tag=F77 ${FORTRANC}" OPTS="${FFLAGS}" \
		NOOPT="${NOOPT}" || die "Failed to make lapacklib"

	cd "${S_LAPACK}"/SRC
	einfo "Copying liblapack.a/*.o to ${S_LAPACK}/SRC"
	cp -sf "${S}"/gentoo/liblapack.a/*.o .
	einfo "Copying liblapack.a/*.lo to ${S_LAPACK}/SRC"
	cp -sf "${S}"/gentoo/liblapack.a/*.lo .
	einfo "Copying liblapack.a/.libs/*.o to ${S_LAPACK}/SRC"
	cp -sf "${S}"/gentoo/liblapack.a/.libs/*.o .libs/

	local FORTRANLIB
	if [[ $(gcc-major-version) -ge 4 ]]; then
		FORTRANLIB="-lgfortran"
	else
		FORTRANLIB="-lg2c"
	fi
	einfo "Fortran library is ${FORTRANLIB}"

	if use ifc; then
		${FORTRANC} ${FFLAGS} -shared .libs/*.o -Wl,-soname -Wl,liblapack.so.0 \
			-o liblapack.so.0.0.0 -lblas -lcblas -latlas \
			-L$(gcc-config -L) ${FORTRANLIB} \
			|| die "Failed to create liblapack.so.0.0.0"
		ar cru liblapack.a *.o || die "Failed to create liblapack.a"
		ranlib liblapack.a || die "Failed to prepare liblapack.a"
	else
		libtool --mode=link --tag=CC $(tc-getCC) -o liblapack.la *.lo \
			-rpath "${RPATH}" -lblas -lcblas -latlas ${FORTRANLIB} \
			|| die "Failed to create liblapack.la"
	fi
}

src_install () {
	dodir "${RPATH}"

	cd "${S_LAPACK}"/SRC
	if use ifc; then
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

	eselect lapack add $(get_libdir) ${FILESDIR}/eselect.lapack atlas

	insinto /usr/include/atlas
	cd "${S}"/include
	doins clapack.h || die

	cd "${S}"
	dodoc README || die
	cd "${S}"/doc
	dodoc AtlasCredits.txt ChangeLog || die
	if use doc; then
		dodoc lapackqref.ps || die
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
}

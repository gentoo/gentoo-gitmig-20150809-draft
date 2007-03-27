# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-atlas/blas-atlas-3.7.30.ebuild,v 1.1 2007/03/27 01:16:32 markusle Exp $

inherit eutils toolchain-funcs fortran

DESCRIPTION="Automatically Tuned Linear Algebra Software BLAS implementation"
HOMEPAGE="http://math-atlas.sourceforge.net/"
MY_PN=${PN/blas-/}
SRC_URI="mirror://sourceforge/math-atlas/${MY_PN}${PV}.tar.bz2
		mirror://gentoo/${MY_PN}-3.7.23-shared-libs.patch.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"


RDEPEND="app-admin/eselect-blas
	app-admin/eselect-cblas"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5"
PROVIDE="virtual/blas"


S="${WORKDIR}/ATLAS"
BLD_DIR="${S}/gentoo-build"
RPATH="${DESTTREE}/$(get_libdir)/blas"
FORTRAN="g77 gfortran"

pkg_setup() {
	fortran_pkg_setup
	echo
	ewarn "Please make sure to disable CPU throttling completely"
	ewarn "during the compile of blas-atlas. Otherwise, all atlas"
	ewarn "generated timings will be completely random and the"
	ewarn "performance of the resulting libraries will be degraded"
	ewarn "considerably."
	echo
	ewarn "For users of <=gcc-4.1.1 only:"
	ewarn "If you experience failing SANITY tests during"
	ewarn "atlas' compile please try passing -mfpmath=387; this"
	ewarn "option might also result in much better performance"
	ewarn "than using then sse instruction set depending on your"
	ewarn "CPU."
	echo
	epause 10
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${DISTDIR}"/${MY_PN}-3.7.23-shared-libs.patch.bz2
	epatch "${FILESDIR}"/${MY_PN}-asm-gentoo.patch

	# make sure shared libs link against proper libraries
	if [[ ${FORTRANC} == "gfortran" ]]; then
		libs="${LDFLAGS} -lpthread -lgfortran"
	else
		libs="${LDFLAGS} -lpthread -lg2c"
	fi
	sed -e "s:SHRD_LNK:${libs}:g" -i Make.top || \
		die "Failed to add addtional libs to shared object build"

	sed -e "s:= gcc:= $(tc-getCC) ${CFLAGS}:" \
		-i CONFIG/src/SpewMakeInc.c || die "Failed to fix Spewmake"

	mkdir ${BLD_DIR}  || die "failed to generate build directory"
	cp "${FILESDIR}"/war ${BLD_DIR} && chmod a+x ${BLD_DIR}/war || \
		die "failed to install war"

	# force proper 32/64bit libs
	local archselect
	if [[ "${ARCH}" == "amd64" || "${ARCH}" == "ppc64" ]]; then
		archselect="-b 64"
	elif [ "${ARCH}" == "alpha" ]; then
		archselect=""
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
	compdefs="${compdefs} -Ss pmake '\$(MAKE) ${MAKEOPTS}'"
	compdefs="${compdefs} -Si cputhrchk 0 ${archselect}"

	cd ${BLD_DIR} && ../configure ${compdefs} \
		|| die "configure failed"
}

src_compile() {
	cd ${BLD_DIR}
	emake -j1 || die "make failed"

	make shared-strip RPATH=${RPATH}/atlas || \
		die "failed to build shared libraries"

	# build shared libraries of threaded libraries if applicable
	if [ -d gentoo/libptf77blas.a ]; then
		make ptshared-strip RPATH=${RPATH}/threaded-atlas || \
			die "failed to build threaded shared libraries"
	fi
}

src_install () {
	dodir "${RPATH}"/atlas
	cd ${BLD_DIR}/gentoo/libs
	cp -P libatlas* "${D}/${DESTTREE}/$(get_libdir)" || \
		die "Failed to install libatlas"
	cp -P *blas* "${D}/${RPATH}"/atlas || \
		die "Failed to install blas/cblas"

	eselect blas add $(get_libdir) ${FILESDIR}/eselect.blas atlas
	eselect cblas add $(get_libdir) ${FILESDIR}/eselect.cblas atlas

	if [ -d ${BLD_DIR}/gentoo/threaded-libs ]
	then
		dodir "${RPATH}"/threaded-atlas
		cd ${BLD_DIR}/gentoo/threaded-libs
		cp -P * "${D}/${RPATH}"/threaded-atlas || \
			die "Failed to install threaded atlas"

		eselect blas add $(get_libdir) ${FILESDIR}/eselect.blas-threaded threaded-atlas
		eselect cblas add $(get_libdir) ${FILESDIR}/eselect.cblas-threaded threaded-atlas
	fi

	insinto "${DESTTREE}"/include/atlas
	doins "${S}"/include/cblas.h "${S}"/include/atlas_misc.h \
		"${S}"/include/atlas_enum.h || \
		die "failed to install headers"

	# These headers contain the architecture-specific 
	# optimizations determined by ATLAS. The atlas-lapack build 
	# is much shorter if they are available, so save them:
	doins ${BLD_DIR}/include/*.h || \
		die "failed to install timing headers"

	#some docs
	cd "${S}"
	dodoc README doc/{AtlasCredits.txt,ChangeLog}
	use doc && dodoc doc/*.ps
}

pkg_postinst() {
	local THREADED

	if [ -d "${RPATH}"/threaded-atlas ]
	then
		THREADED="threaded-"
	fi
	if [[ -z "$(eselect blas show)" ]]; then
		eselect blas set ${THREADED}atlas
	fi
	if [[ -z "$(eselect cblas show)" ]]; then
		eselect cblas set ${THREADED}atlas
	fi

	elog
	elog "Fortran users link using -lblas"
	elog
	elog "C users compile against the header ${ROOT}usr/include/atlas/cblas.h and"
	elog "link using -lcblas"
	elog
	elog "If using threaded ATLAS, you may also need to link with -lpthread."
	elog
	elog "Configuration now uses eselect rather than blas-config."
}

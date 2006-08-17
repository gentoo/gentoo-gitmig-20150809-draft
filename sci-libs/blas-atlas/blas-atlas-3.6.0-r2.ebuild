# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-atlas/blas-atlas-3.6.0-r2.ebuild,v 1.3 2006/08/17 18:22:29 dberkholz Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Automatically Tuned Linear Algebra Software BLAS implementation"
HOMEPAGE="http://math-atlas.sourceforge.net/"
MY_PN=${PN/blas-/}
SRC_URI="mirror://sourceforge/math-atlas/${MY_PN}${PV}.tar.bz2
	mirror://gentoo/atlas${PV}-shared-libs.1.patch.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND="app-admin/eselect-blas
	app-admin/eselect-cblas"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5"


PROVIDE="virtual/blas"

S=${WORKDIR}/ATLAS

# Libraries will be installed in ${RPATH}/atlas 
# and ${RPATH}/threaded-atlas:
RPATH="${DESTTREE}/lib/blas"


pkg_setup() {
	if [ -z `which g77` ]; then
		eerror "No fortran compiler found on the system!"
		eerror "Please add fortran to your USE flags and reemerge gcc!"
		die
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/unbuffered.patch
	epatch ${DISTDIR}/atlas3.6.0-shared-libs.1.patch.bz2
	epatch ${FILESDIR}/${PV}-ppc-configure.patch
	sed -i -e "s:ASM:ASM VOLATILE:" include/contrib/camm_dpa.h || die "sed failed to fix clobbering"
	cp ${FILESDIR}/war ${S}
	chmod a+x ${S}/war
}

atlas_fail() {
	eerror
	eerror "ATLAS auto-config failed."
	eerror "Please run 'interactive=1 emerge blas-atlas' to configure manually."
	eerror
	die "ATLAS auto-config failed."
}

# Added to allow compilation on sparc architecture. The default CCFLAG0
# and MMFLAGS are *bad*.
# Danny van Dyk <kugelfang@gentoo.org> 2004/07/02
#
reconfigure() {
	case "`uname -p`" in
		"sun4m")
			MY_CCFLAGS="-O3 -mcpu=v8"
			MY_CXXFLAGS="${MY_CCFLAGS}"
			MY_MMFLAGS="-O -mcpu=v8"
			MY_LDFLAGS=""
			;;
		"sun4u")
			MY_CCFLAGS="-O3 -mcpu=ultrasparc"
			MY_CXXFLAGS="${MY_CCFLAGS}"
			MY_MMFLAGS="-O -mcpu=ultrasparc"
			MY_LDFLAGS=""
			;;
		*)
			MY_CCFLAGS="${CFLAGS}"
			MY_CXXFLAGS="${CXXFLAGS}"
			MY_MMFLAGS="${CFLAGS}"
			MY_LDFLAGS="${LDFLAGS}"
			;;
	esac

	MY_FILE="`find -name Make.Linux*`"

	sed -i -e "s/CCFLAG0 =.*/CCFLAG0 = \$(CDEFS) ${MY_CCFLAGS}/" \
		-e "s/CCFLAGS =.*/CCFLAGS = \$(CDEFS) ${MY_CCFLAGS}/" \
		-e "s/CLINKFLAGS =.*/CLINKFLAGS =\$(CDEFS) ${MY_LDFLAGS}/" \
		-e "s/XCCFLAGS =.*/XCCFLAGS =\$(CDEFS) ${MY_CXXFLAGS}/" \
		-e "s/MMFLAGS =.*/MMFLAGS = ${MY_MMFLAGS}/" \
		${MY_FILE} || die "sed didnt complete"

}

src_compile() {
	if [ -n "${interactive}" ]
	then
		echo "${interactive}"
		make config CC="$(tc-getCC) -DUSE_LIBTOOL -DINTERACTIVE" || die
	else
		# Use ATLAS defaults for all questions:
		(echo | make config CC="$(tc-getCC) -DUSE_LIBTOOL") || atlas_fail
	fi

	reconfigure

	TMPSTR=$(ls Make.Linux*)
	ATLAS_ARCH=${TMPSTR#'Make.'}

	make install arch=${ATLAS_ARCH} || die

	make shared-strip arch=${ATLAS_ARCH} RPATH=${RPATH}/atlas || die

	# Build shared versions of the threaded libs.
	# ATLAS only compiles threaded libs on multiprocessor machines.
	if [ -d gentoo/libptf77blas.a ]
	then
		make ptshared-strip \
			arch=${ATLAS_ARCH} RPATH=${RPATH}/threaded-atlas || die
	fi
}

src_install () {
	dodir ${RPATH}/atlas
	cd ${S}/gentoo/libs
	cp -P libatlas* ${D}/${DESTTREE}/lib
	cp -P *blas* ${D}/${RPATH}/atlas #the rest really

	eselect blas add $(get_libdir) ${FILESDIR}/eselect.blas atlas
	eselect cblas add $(get_libdir) ${FILESDIR}/eselect.cblas atlas

	if [ -d ${S}/gentoo/threaded-libs ]
	then
		dodir ${RPATH}/threaded-atlas
		cd ${S}/gentoo/threaded-libs
		cp -P * ${D}/${RPATH}/threaded-atlas
		eselect blas add $(get_libdir) ${FILESDIR}/eselect.blas-threaded threaded-atlas
		eselect cblas add $(get_libdir) ${FILESDIR}/eselect.cblas-threaded threaded-atlas
	fi

	insinto ${DESTTREE}/include/atlas
	doins ${S}/include/cblas.h ${S}/include/atlas_misc.h
	doins ${S}/include/atlas_enum.h

	# These headers contain the architecture-specific optimizations determined
	# by ATLAS. The atlas-lapack build is much shorter if they are available,
	# so save them:
	doins ${S}/include/${ATLAS_ARCH}/*.h

	#some docs
	cd ${S}
	dodoc README doc/{AtlasCredits.txt,ChangeLog}
	use doc && dodoc doc/*.ps
}

pkg_postinst() {
	local THREADED

	if [ -d ${RPATH}/threaded-atlas ]
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

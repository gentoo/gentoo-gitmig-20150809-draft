# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/blas-atlas/blas-atlas-3.6.0.ebuild,v 1.16 2004/11/01 00:45:17 ribosome Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Automatically Tuned Linear Algebra Software BLAS implementation"
HOMEPAGE="http://math-atlas.sourceforge.net/"
MY_PN=${PN/blas-/}
SRC_URI="mirror://sourceforge/math-atlas/${MY_PN}${PV}.tar.bz2
	mirror://gentoo/atlas${PV}-shared-libs.patch.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~ppc64 sparc ~alpha"
IUSE="doc"

DEPEND="app-sci/blas-config
	>=sys-devel/libtool-1.5"

RDEPEND=""

PROVIDE="virtual/blas"

S=${WORKDIR}/ATLAS

pkg_setup() {
	if [ -z `which g77` ]; then
		eerror "No fortran compiler found on the system!"
		eerror "Please add f77 to your USE flags and reemerge gcc!"
		die
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${DISTDIR}/atlas3.6.0-shared-libs.patch.bz2
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
			MY_CCFLAG0="-O3 -mcpu=v8"
			MY_MMFLAGS="-O -mcpu=v8"
			;;
		"sun4u")
			MY_CCFLAG0="-O3 -mcpu=ultrasparc"
			MY_MMFLAGS="-O -mcpu=ultrasparc"
			;;
		*)
			MY_CCFLAG0="${CFLAGS}"
			MY_MMFLAGS="${CFLAGS}"
			;;
	esac

	MY_FILE="`find -name Make.Linux*`"

	sed -i -e "s/CCFLAG0 =/CCFLAG0 = ${MY_CCFLAG0}\n#&/1" ${MY_FILE}
	sed -i -e "s/MMFLAGS =/MMFLAGS = ${MY_MMFLAGS}\n#&/" ${MY_FILE}
}

src_compile() {
	# Libraries will be installed in ${RPATH}/atlas and ${RPATH}/threaded-atlas:
	RPATH="${DESTTREE}/lib/blas"

	if [ -n "${interactive}" ]
	then
		echo "${interactive}"
		make config CC="$(tc-getCC) -DUSE_LIBTOOL -DINTERACTIVE" || die
	else
		# Use ATLAS defaults for all questions:
		(echo | make config CC="$(tc-getCC) -DUSE_LIBTOOL") || atlas_fail
	fi

	if [ "${ARCH}" == "sparc" ]; then
		reconfigure
	fi

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

	insinto ${RPATH}
	doins ${FILESDIR}/c-ATLAS ${FILESDIR}/f77-ATLAS

	if [ -d ${S}/gentoo/threaded-libs ]
	then
		dodir ${RPATH}/threaded-atlas
		cd ${S}/gentoo/threaded-libs
		cp -P * ${D}/${RPATH}/threaded-atlas
		doins ${FILESDIR}/c-threaded-ATLAS ${FILESDIR}/f77-threaded-ATLAS
	fi

	insinto ${DESTTREE}/include/atlas
	doins ${S}/include/cblas.h

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
	if [ -d ${RPATH}/threaded-atlas ]
	then
		${DESTTREE}/bin/blas-config threaded-ATLAS
	else
		${DESTTREE}/bin/blas-config ATLAS
	fi

	einfo
	einfo "Fortran users link using -lblas"
	einfo
	einfo "C users compile against the header /usr/include/atlas/cblas.h and"
	einfo "link using -lcblas"
	einfo
}

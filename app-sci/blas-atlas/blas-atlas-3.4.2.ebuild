# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/blas-atlas/blas-atlas-3.4.2.ebuild,v 1.1 2004/02/02 19:09:43 george Exp $

inherit eutils

DESCRIPTION="Automatically Tuned Linear Algebra Software BLAS implementation"
HOMEPAGE="http://math-atlas.sourceforge.net/"
MY_PN=${PN/blas-/}
SRC_URI="mirror://sourceforge/math-atlas/${MY_PN}${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="app-sci/blas-config
	sys-devel/libtool"

RDEPEND=""

PROVIDE="virtual/blas"

S=${WORKDIR}/ATLAS

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/atlas-gentoo.patch.bz2
	cp ${FILESDIR}/war ${S}
	chmod a+x ${S}/war
}

atlas_fail() {
	eerror
	eerror "ATLAS auto-config failed."
	eerror "Please run 'interactive=1 emerge atlas-blas' to configure manually."
	eerror
	die "ATLAS auto-config failed."
}

src_compile() {
	# Libraries will be installed in ${RPATH}/atlas and ${RPATH}/threaded-atlas:
	RPATH="${DESTTREE}/lib/blas"

	GCC="gcc"

	if [ -n "${interactive}" ]
	then
		echo "${interactive}"
		make config CC="${GCC} -DUSE_LIBTOOL -DINTERACTIVE" || die
	else
		# Use ATLAS defaults for all questions:
		(echo | make config CC="${GCC} -DUSE_LIBTOOL") || atlas_fail
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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/blas-reference/blas-reference-19940131.ebuild,v 1.1 2004/02/02 03:13:05 george Exp $

Name="blas"
DESCRIPTION="FORTRAN reference implementation of the BLAS (linear algebra lib)"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/${Name}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE="ifc"

DEPEND="app-sci/blas-config
	sys-devel/libtool
	ifc? ( dev-lang/ifc )"

RDEPEND="ifc? ( dev-lang/ifc )" # Need ifc runtime libraries

PROVIDE="virtual/blas"

S=${WORKDIR}

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
		sleep 5
	fi
}

src_compile() {
	cd ${S}
	cp ${FILESDIR}/Makefile.bz2 .
	bunzip2 Makefile.bz2

	# Profile information will be installed in TOP_PATH:
	TOP_PATH=${DESTTREE}/lib/blas
	# Libraries will be installed in RPATH:
	RPATH=${TOP_PATH}/reference

	if [ "`use ifc`" ]
	then
		ifc_info
		make static FC="ifc" FFLAGS="${IFCFLAGS}"
		ifc -shared ${IFCFLAGS} \
			-Wl,-soname,libblas.so.0 -o libblas.so.0.0.0 *.lo
	else
		# libg2c is required to link to libblas.so using ifc:
		make libs \
			FC="g77" \
			FFLAGS="${CFLAGS}" \
			LIBTOOL_FLAGS="-rpath ${RPATH} -lg2c" \
			|| die
	fi
}

src_install() {
	if [ "`use ifc`" ]
	then
		strip --strip-unneeded libblas.so.0.0.0
		strip --strip-debug libblas.a

		exeinto ${RPATH}
		doexe libblas.so.0.0.0
		dosym libblas.so.0.0.0 ${RPATH}/libblas.so.0
		dosym libblas.so.0.0.0 ${RPATH}/libblas.so

		insinto ${RPATH}
		doins libblas.a
	else
		dodir ${RPATH}
		libtool install -s libblas.la ${D}/${RPATH}
	fi

	insinto ${TOP_PATH}
	doins ${FILESDIR}/f77-reference
}

pkg_postinst() {
	blas-config f77-reference
}

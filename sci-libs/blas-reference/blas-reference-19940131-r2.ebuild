# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-reference/blas-reference-19940131-r2.ebuild,v 1.4 2006/05/15 06:41:19 spyderous Exp $

inherit eutils fortran

Name="blas"
DESCRIPTION="FORTRAN reference implementation of the BLAS (linear algebra lib)"
LICENSE="public-domain"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/${Name}.tgz"

SLOT="0"
IUSE="ifc"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="sci-libs/blas-config
	>=sys-devel/libtool-1.5
	ifc? ( dev-lang/ifc )"

RDEPEND="ifc? ( dev-lang/ifc )" # Need ifc runtime libraries

PROVIDE="virtual/blas"

#TODO: detect 64bit size from compiler, not eclass
FORTRAN="g77 ifc" || FORTRAN="g77 f2c ifc" # No f2c on 64-bit systems yet :-/

S="${WORKDIR}"

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
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}"/Makefile .
}

src_compile() {
	# Profile information will be installed in TOP_PATH:
	TOP_PATH="${DESTTREE}"/lib/blas
	# Libraries will be installed in RPATH:
	RPATH="${TOP_PATH}"/reference

	if use ifc; then
		ifc_info
		make static FC="ifc" FFLAGS="${IFCFLAGS}" || die
		libtool --tag=F77 --mode=link ifc -shared ${IFCFLAGS} \
			-Wl,-soname,libblas.so.0 -o libblas.so.0.0.0 *.lo || die
	else
		# libg2c is required to link to libblas.so using ifc:
		make libs FC="g77" FFLAGS="${CFLAGS}" \
			LIBTOOL_FLAGS="-rpath ${RPATH} -lg2c" || die
	fi
}

src_install() {
	if use ifc; then
		strip --strip-unneeded libblas.so.0.0.0 || die
		strip --strip-debug libblas.a || die

		exeinto ${RPATH}
		doexe libblas.so.0.0.0 || die
		dosym libblas.so.0.0.0 ${RPATH}/libblas.so.0 || die
		dosym libblas.so.0.0.0 ${RPATH}/libblas.so || die

		insinto ${RPATH}
		doins libblas.a || die
	else
		dodir ${RPATH} || die
		libtool install -s libblas.la ${D}/${RPATH} || die
	fi

	insinto ${TOP_PATH}
	doins ${FILESDIR}/f77-reference || die
}

pkg_postinst() {
	blas-config f77-reference
}

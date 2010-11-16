# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cyana/cyana-2.1.ebuild,v 1.3 2010/11/16 17:16:51 jlec Exp $

EAPI="3"

inherit eutils fortran toolchain-funcs

# we need libg2c for gfortran # 136988
FORTRAN="ifc"

DESCRIPTION="Combined assignment and dynamics algorithm for NMR applications"
HOMEPAGE="http://www.las.jp/english/products/s08_cyana/index.html"
SRC_URI="${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="as-is"
IUSE="examples"

RESTRICT="fetch"

pkg_nofetch() {
	elog "Please visit"
	elog "http://www.las.jp/english/products/s08_cyana/licenses.html"
	elog "and get a copy of ${A}."
	elog "Place it in ${DISTDIR}."
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-typo.patch
	epatch "${FILESDIR}"/${PV}-exec.patch
	epatch "${FILESDIR}"/${PV}-expire.patch

	cat >> etc/config <<- EOF
	VERSION=${PV}
	SHELL=${EPREFIX}/bin/sh
	FC=${FORTRANC}
	FFLAGS=${FFLAGS}
	FFLAGS2=${FFLAGS}
	CC=$(tc-getCC)
	FORK=g77fork.o
	LDFLAGS=${LDFLAGS}
	LIBS=-pthread -lpthread -liomp5
	EOF

	if [[ ${FORTRANC} == gfortran ]]; then
		cat >> etc/config <<- EOF
		DEFS=-Dgfortran
		SYSTEM=gfortran
		EOF
	else
		cat >> etc/config <<- EOF
		DEFS=-Dintel
		SYSTEM=intel
		EOF
	fi
}

src_compile() {
	cd src
	emake \
		|| die
}

src_install() {
	dobin cyana{job,table,filter,clean} || die
	newbin src/${PN}/${PN}exe.${SYSTEM} ${PN} || die
	insinto /usr/share/${PN}
	doins -r lib macro help || die
	use examples && doins -r demo

	cat >> "${T}"/20cyana <<- EOF
	CYANALIB="${EPREFIX}/usr/share/${PN}"
	EOF

	doenvd "${T}"/20cyana || die
}

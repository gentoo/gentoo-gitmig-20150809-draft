# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/eden/eden-5.3-r1.ebuild,v 1.2 2011/12/16 12:59:33 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils multilib python toolchain-funcs

MY_P="${PN}_V${PV}"

DESCRIPTION="A crystallographic real-space electron-density refinement and optimization program"
HOMEPAGE="http://www.gromacs.org/pipermail/eden-users/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="double-precision"

RDEPEND="
	sci-libs/fftw:2.1
	sci-libs/gsl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}"

SRC="${S}/source"
EDENHOME="${EPREFIX}/usr/$(get_libdir)/eden"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-makefile-fixes.patch

	sed -i \
		-e "s:^\(FFTW.*=\).*:\1 ${EPREFIX}/usr:g" \
		-e "s:^\(LIB.*=.*\$(FFTW)/\).*:\1$(get_libdir):g" \
		-e "s:^\(BIN.*=\).*:\1 ${D}usr/bin:g" \
		-e "s:^\(CFLAGS.*=\).*:\1 ${CFLAGS}:g" \
		-e "s:-lgsl -lgslcblas:$(pkg-config --libs gsl):g" \
		${SRC}/Makefile || die

	if ! use double-precision; then
		sed -i -e "s:^\(DOUBLESWITCH.*=\).*:\1 OFF:g" ${SRC}/Makefile || die
		EXE="seden"
	else
		EXE="deden"
	fi
}

src_compile() {
	emake CC=$(tc-getCC) -C ${SRC} || die "emake failed"
}

src_install() {
	emake -C ${SRC} install || die "install failed"

	exeinto ${EDENHOME}/python
	doexe python/* || die

	insinto ${EDENHOME}/help
	doins help/* || die

	insinto ${EDENHOME}/tools
	doins tools/* || die

	dodoc manual/UserManual.pdf || die

	cat >> "${T}"/eden <<- EOF
	#!/bin/bash
	export EDENHOME="${EDENHOME}"
	${EXE} \$*
	EOF

	dobin "${T}"/eden || die

	cat >> "${T}"/ieden <<- EOF
	#!/bin/bash
	export EDENHOME="${EDENHOME}"
	$(PYTHON) -O \${EDENHOME}/python/eden.py
	EOF

	dobin "${T}"/ieden || die
}

pkg_postinst() {
	python_mod_optimize ${EDENHOME}/python
}

pkg_postrm() {
	python_mod_cleanup ${EDENHOME}/python
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xfoil/xfoil-6.94-r1.ebuild,v 1.2 2004/03/30 19:58:15 spyderous Exp $

inherit gcc

MY_PN="${PN}"
MY_PN_upper="`echo ${PN} | tr '[:lower:]' '[:upper:]'`"
MY_PV="${PV/./}"
MY_P="${MY_PN}${MY_PV}"
MY_P_upper="${MY_PN_upper}${MY_PV}"

DESCRIPTION="XFOIL - design and analysis of subsonic isolated airfoils"
HOMEPAGE="http://raphael.mit.edu/xfoil/"
SRC_FILE="${MY_P}.tar.gz"
SRC_URI="${HOMEPAGE}/${SRC_FILE} doc? ( ${HOMEPAGE}/xfoil_doc.ps ${HOMEPAGE}/xfoil_doc.pdf )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/blas
	app-sci/blas-config
	virtual/x11"

RDEPEND="virtual/x11"

S=${WORKDIR}/${MY_P_upper}


src_unpack() {
	unpack ${A}
	cd ${S}
	[ -z "$FC" ] && FC=g77 # because gcc-config doesn't do it yet
	[ -z "${FFLAGS}" ] && FFLAGS="${CFLAGS}" # because gcc-config doesn't do it yet
	echo "CC = ${CC}" >>plotlib/config.make
	echo "FC = ${FC}" >>plotlib/config.make
	echo "CFLAGS += ${CFLAGS}" >>plotlib/config.make
	echo "FFLAGS += ${FFLAGS}" >>plotlib/config.make
	sed -i bin/Makefile \
	-e "s/^\(FC.*\)/FC = ${FC}/g" \
	-e "s/^\(CC.*\)/CC = ${CC}/g" \
	-e "s/^\(FFLAGS .*\)/FFLAGS = ${FFLAGS}/g" \
	-e "s/^\(FFLOPT .*\)/FFLOPT = \$(FFLAGS)/g" \
	-e "s/^\(FFLAGS2 .*\)/FFLAGS2 = \$(FFLAGS)/g"
}

src_compile() {
	cd ${S}/plotlib
	emake || die "failed to build plotlib"
	cd ${S}/bin
	for i in xfoil pplot pxplot; do
		emake ${i} || die "failed to build ${i}"
	done
}

src_install() {
	dobin bin/pplot bin/pxplot bin/xfoil
	dodoc version_notes.txt  xfoil_doc.txt sessions.txt README
	use doc && dodoc ${DISTDIR}/xfoil_doc.ps ${DISTDIR}/xfoil_doc.pdf
	docinto runs
	dodoc runs/*
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/platon/platon-20051215.ebuild,v 1.1 2005/12/16 05:32:46 spyderous Exp $

inherit fortran

FORTRAN="g77"
DESCRIPTION="Versatile, SHELX-97 compatible, multipurpose crystallographic tool"
HOMEPAGE="http://www.cryst.chem.uu.nl/platon/"
SRC_URI="${P}.tar.gz"
RESTRICT="fetch"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="|| ( x11-libs/libX11 virtual/x11 )"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

pkg_nofetch() {
	einfo "Download ${A/-${PV}} from ${HOMEPAGE},"
	einfo "rename it to ${A} and place it"
	einfo "in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	gunzip platon.f.Z xdrvr.c.gz
}

src_compile() {
	COMMAND="${FORTRANC} -o platon ${FFLAGS:- -O2} platon.f xdrvr.c -lX11"
	echo ${COMMAND}
	${COMMAND} || die "Compilation failed"
}

src_install() {
	dobin platon

	dosym platon /usr/bin/pluton
	dosym platon /usr/bin/s
	dosym platon /usr/bin/cifchk
	dosym platon /usr/bin/helena
	dosym platon /usr/bin/stidy

	insinto /usr/lib/platon
	doins check.def

	echo "CHECKDEF=\"/usr/lib/platon/check.def\"" > ${T}/env.d
	newenvd ${T}/env.d 50platon

	dodoc README.* VALIDATION.DOC
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/nmrview/nmrview-5.2.2.ebuild,v 1.1 2004/12/16 16:26:30 ribosome Exp $

DESCRIPTION="NMRView - Visualisation and analysis of processed NMR data"
LICENSE="as-is"
HOMEPAGE="http://www.onemoonscientific.com/nmrview/"
SRC_URI="${PN}${PV}.lib.tar.gz
	${PN}${PV//./_}_01_linux.gz"
RESTRICT="fetch"

SLOT="0"
IUSE=""
KEYWORDS="-* ~x86"

DEPEND="virtual/x11
	=dev-lang/tcl-8.4*
	=dev-lang/tk-8.4*"

S=${WORKDIR}

INSTDIR="/opt/nmrview"

pkg_nofetch() {
	einfo "Please visit:"
	einfo "	${HOMEPAGE}"
	einfo
	einfo "Complete the registration process, then download the following files:"
	einfo "	${A}"
	einfo
	einfo "Place the downloaded files in the following directory:"
	einfo "	${DISTDIR}"
	echo
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	exeinto ${INSTDIR}/bin
	newexe ${PN}${PV//./_}_01_linux nmrview
	DIRS="help html images nvtcl nvtclC nvtclExt reslib star tcl8.4 tk8.4 tools"
	cp -r ${DIRS} ${D}/${INSTDIR}
	dodoc README
	dosym ${INSTDIR}/html /usr/share/doc/${PF}/html
	insinto /etc/env.d
	newins ${FILESDIR}/${PN}-env ${PN}
}

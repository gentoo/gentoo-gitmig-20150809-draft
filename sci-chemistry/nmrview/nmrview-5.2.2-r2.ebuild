# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/nmrview/nmrview-5.2.2-r2.ebuild,v 1.1 2005/02/03 21:00:53 ribosome Exp $

DESCRIPTION="NMRView - Visualisation and analysis of processed NMR data"
LICENSE="as-is"
HOMEPAGE="http://www.onemoonscientific.com/nmrview/"
SRC_URI="${PN}${PV}.lib.tar.gz
	${PN}${PV//./_}_01_linux.gz"
RESTRICT="fetch"

SLOT="0"
IUSE=""
KEYWORDS="-* ~x86"

RDEPEND="virtual/x11"

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
	echo
	einfo "Nothing to compile."
	echo
}

src_install() {
	exeinto /usr/bin
	newexe ${FILESDIR}/${PN}.sh ${PN}
	exeinto ${INSTDIR}
	doexe ${PN}${PV//./_}_01_linux
	DIRS="help html images nvtcl nvtclC nvtclExt reslib star tcl8.4 tk8.4 tools"
	cp -r ${DIRS} ${D}/${INSTDIR}
	dodoc README
	dosym ${INSTDIR}/html /usr/share/doc/${PF}/html
}

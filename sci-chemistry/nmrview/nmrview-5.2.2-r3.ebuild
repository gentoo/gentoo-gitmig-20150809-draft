# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/nmrview/nmrview-5.2.2-r3.ebuild,v 1.3 2006/07/12 13:38:19 ribosome Exp $

DESCRIPTION="Visualisation and analysis of processed NMR data"
LICENSE="as-is"
HOMEPAGE="http://www.onemoonscientific.com/nmrview/"
SRC_URI="${PN}${PV}.lib.tar.gz
	${PN}${PV//./_}_01_linux.gz"
RESTRICT="fetch"

SLOT="0"
IUSE=""
KEYWORDS="-* x86"

RDEPEND="|| ( x11-libs/libX11 virtual/x11 )"

S="${WORKDIR}"

INSTDIR="/opt/nmrview"

pkg_nofetch() {
	einfo "Please visit:"
	einfo "\t${HOMEPAGE}"
	einfo
	einfo "Complete the registration process, then download the following files:"
	einfo "\t${A}"
	einfo
	einfo "Place the downloaded files in your distfiles directory:"
	einfo "\t${DISTDIR}"
	echo
}

src_compile() {
	echo
	einfo "Nothing to compile."
	echo
}

src_install() {
	insinto ${INSTDIR}

	exeinto /usr/bin
	newexe "${FILESDIR}"/${PN}.sh-r1 ${PN} || \
		die "Failed to install wrapper script"
	exeinto ${INSTDIR}
	doexe ${PN}${PV//./_}_01_linux || die "Failed to install binary."

	DIRS="help html images nvtcl nvtclC nvtclExt reslib star tcl8.4 tk8.4 tools"
	doins -r ${DIRS} || die "Failed to install shared files."

	dodoc "${FILESDIR}"/README.Gentoo || die "Failed to install Gentoo README."
	doins README || die "Failed to install README."
	dosym ${INSTDIR}/html /usr/share/doc/${PF}/html || die \
		"Failed to link HTML documentation."
	dosym ${INSTDIR}/README /usr/share/doc/${PF}/README || die \
		"Failed to link README."
}

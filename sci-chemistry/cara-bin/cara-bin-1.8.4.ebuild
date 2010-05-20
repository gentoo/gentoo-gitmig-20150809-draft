# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cara-bin/cara-bin-1.8.4.ebuild,v 1.3 2010/05/20 12:10:45 jlec Exp $

EAPI="3"

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="An application for the analysis of NMR spectra and Computer Aided Resonance Assignment"
SRC_URI="http://www.cara.nmr-software.org/downloads/${MY_P}_linux.gz
		 ftp://ftp.mol.biol.ethz.ch/software/${MY_PN}/Start1.2.cara"
HOMEPAGE="http://www.nmr.ch"

RESTRICT="mirror"
LICENSE="CARA"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="lua"

RDEPEND="
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat )
	x86? (
		media-libs/fontconfig
		media-libs/freetype
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrandr
		x11-libs/libXrender
		virtual/libstdc++ )
	lua? ( dev-lang/lua )"
DEPEND=""

src_unpack(){
	unpack ${MY_P}_linux.gz
	cp "${DISTDIR}"/Start1.2.cara "${WORKDIR}"
}

src_install() {
	exeinto "/opt/cara"
	doexe cara_1.8.4_linux || die
	dosym cara_1.8.4_linux /opt/cara/cara || die
	dodoc Start1.2.cara || die

	cat >>"${T}"/20cara<<- EOF
	PATH="${EPREFIX}/opt/cara/"
	EOF

	doenvd "${T}"/20cara || die
}

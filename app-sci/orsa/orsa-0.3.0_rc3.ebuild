# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/orsa/orsa-0.3.0_rc3.ebuild,v 1.2 2003/07/19 20:50:48 vapier Exp $

inherit base flag-o-matic

DESCRIPTION="Orbital Reconstruction, Simulation and Analysis"
HOMEPAGE="http://orsa.sourceforge.net/"
SRC_URI="mirror://sourceforge/orsa/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	dev-libs/fftw
	dev-libs/gsl
	x11-libs/qt
	sys-libs/readline"

S=${WORKDIR}/${PN}_${PV}

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

src_compile() {
	econf || die "configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
}

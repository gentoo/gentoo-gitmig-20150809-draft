# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/orsa/orsa-0.3.0_rc3.ebuild,v 1.1 2003/07/09 22:26:59 george Exp $

IUSE=""

#inherit sourceforge
inherit base
inherit flag-o-matic

Name=${P/_/-}
S=${WORKDIR}/${Name}
DESCRIPTION="ORSA Orbital Reconstruction Simulation Algorithym"
SRC_URI="http://unc.dl.sourceforge.net/orsa/${Name}.tar.gz"
HOMEPAGE="http://orsa.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
		dev-libs/fftw
		dev-libs/gsl
		x11-libs/qt
		sys-libs/readline"


replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

src_compile() {
	econf || die "configure failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS
}

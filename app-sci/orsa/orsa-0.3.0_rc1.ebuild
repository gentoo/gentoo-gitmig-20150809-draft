# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/orsa/orsa-0.3.0_rc1.ebuild,v 1.2 2003/07/11 19:55:41 aliz Exp $

IUSE=""

#inherit sourceforge
inherit base
inherit flag-o-matic

Name=${P/_/-}
S=${WORKDIR}/${Name}
DESCRIPTION="ORSA Orbital Reconstruction Simulation Algorithym"
SRC_URI="http://download.sourceforge.net/${PN}/${Name}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
		dev-libs/fftw
		dev-libs/gsl
		x11-libs/qt
		sys-libs/readline"


replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

src_compile() {

#Avoid locking (can break parallel builds)

#	./configure \
#		--host=${CHOST} \
#		--prefix=/usr \
#		--infodir=/usr/share/info \
#		--mandir=/usr/share/man || die "./configure failed"

	econf || die
	emake || die

	#Uncomment the 'make check ...' line if you want to run the test suite.
	#Note that the check.log file will be several megabytes in size.
	#make check > ${WORKDIR}/check.log 2>&1 || die

}

src_install () {

	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS

}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e-fancylauncher/e-fancylauncher-0.7.ebuild,v 1.5 2004/07/15 00:51:55 agriffis Exp $

S="${WORKDIR}/Epplets-${PV}"

DESCRIPTION="E-FancyLauncher epplet"
SRC_URI="http://www.docs.uu.se/~adavid/Epplets/E-FancyLauncher-${PV}.tgz"

HOMEPAGE="http://www.docs.uu.se/~adavid/Epplets"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""
S=${WORKDIR}/E-FancyLauncher

DEPEND="x11-plugins/epplets"

src_compile() {
	make clean
	emake
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/enlightenment
	EBIN=${D}/usr/bin \
	EROOT=${D}/usr/share/enlightenment \
	einstall
	dodoc ChangeLog
}

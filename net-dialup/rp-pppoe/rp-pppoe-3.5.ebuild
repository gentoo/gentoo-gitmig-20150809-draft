# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.5.ebuild,v 1.8 2003/07/19 19:57:29 pvdabeel Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
SRC_URI="http://www.roaringpenguin.com/pppoe/${P}.tar.gz"
HOMEPAGE="http://www.roaringpenguin.com/"

DEPEND=">=net-dialup/ppp-2.4.1 X? ( virtual/x11 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE="X"

src_compile() {
	econf 
	emake || die "Failed to compile"

	if [ `use X` ]; then
		cd ../gui ; make || die "Failed to compile the GUI"
	fi
}

src_install () {
	make RPM_INSTALL_ROOT=${D} docdir=/usr/share/doc/${PF} install || die "Failed to install"
	prepalldocs

	if [ `use X` ]; then
		cd ../gui ; make RPM_INSTALL_ROOT=${D} \
		datadir=/usr/share/doc/${PF}/ install || die "Failed to install the GUI"
		dosym /usr/share/doc/${PF}/tkpppoe /usr/share/tkpppoe
	fi
}

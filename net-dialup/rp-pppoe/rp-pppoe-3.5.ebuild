# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.5.ebuild,v 1.13 2003/09/08 07:10:17 msterret Exp $

DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
SRC_URI="http://www.roaringpenguin.com/pppoe/${P}.tar.gz"
HOMEPAGE="http://www.roaringpenguin.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~sparc x86"
IUSE="X"

DEPEND=">=net-dialup/ppp-2.4.1
	X? ( virtual/x11 )"

S=${WORKDIR}/${P}/src

src_compile() {
	addpredict /dev/ppp
	econf || die
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

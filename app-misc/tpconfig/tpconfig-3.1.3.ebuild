# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tpconfig/tpconfig-3.1.3.ebuild,v 1.1 2002/10/23 19:30:24 lostlogic Exp $

IUSE=""

DESCRIPTION="Touchpad config for ALPS and Synaptics TPs. Controls tap/click behaviour"
HOMEPAGE="http://www.compass.com/synaptics/"
LICENSE="GPL"
DEPEND="virtual/glibc"
SRC_URI="http://www.compass.com/${PN}/${P}.tar.gz"
S=${WORKDIR}/${P}
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	econf || die "Failed econf"
	emake || die "Failed emake"
}

src_install () {
	dobin tpconfig
	dodoc README AUTHORS NEWS INSTALL COPYING
	exeinto /etc/init.d ; doexe ${FILESDIR}/tpconfig
	insinto /etc/conf.d ; newins ${FILESDIR}/tpconfig.conf tpconfig
}
 

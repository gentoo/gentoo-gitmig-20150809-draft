# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irda-utils/irda-utils-0.9.13.ebuild,v 1.6 2002/07/21 20:02:05 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IrDA Utilities, tools for IrDA communication"
SRC_URI="ftp://irda.sourceforge.net/pub/irda/${PN}/${P}.tar.gz"
HOMEPAGE="http://mrproject.codefactory.se/"
KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/irdadump
        cp autogen.sh autogen.sh.orig
        sed -e "s:1.2:1.4:g" autogen.sh.orig > autogen.sh
        rm autogen.sh.orig
}

src_compile() {
	make ROOT="${D}" RPM_BUILD_ROOT="${D}" || die "Making failed."
}

src_install () {
	dodir /etc/rc.d/init.d
 	dodir /usr/bin
 	dodir /usr/sbin
	dodir /usr/X11R6/bin

	cd ${S}/irdadump
	make install ROOT="${D}" || die "Couldn't install from ${S}/irdadump."
	
	cd ${S}/etc
	make install ROOT="${D}" || die "Couldn't install from ${S}/etc."
	
	cd ${S}
	into /usr
	dobin psion/irpsion5
	dobin irsockets/irdaspray
	dobin tekram/irkbd

	dosbin irattach/irattach
	dosbin irattach/dongle_attach
	dosbin irdaping/irdaping
	dosbin findchip/findchip

	dodoc README
}


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irda-utils/irda-utils-0.9.13.ebuild,v 1.14 2003/06/21 21:19:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IrDA Utilities, tools for IrDA communication"
SRC_URI="mirror://sourceforge/irda/${P}.tar.gz"
HOMEPAGE="http://irda.sourceforge.net/"
KEYWORDS="x86 amd64 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc >=dev-libs/glib-1.2"

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

src_install() {
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

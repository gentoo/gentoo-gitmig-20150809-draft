# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/pump/pump-0.8.3.ebuild,v 1.4 2001/07/25 05:40:25 lamer Exp $
A=pump_0.8.3.orig.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="This is the DHCP/BOOTP client written by RedHat."
SRC_URI="http://ftp.debian.org/debian/pool/main/p/pump/${A}"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/p/pump/"
DEPEND=">=dev-libs/popt-1.5"

#RDEPEND=""

src_compile() {
	try make pump
}

src_install () {
	 exeinto /sbin
	 doexe pump
	 insinto /etc
	 doins ${FILESDIR}/pump.conf
	 doman pump.8
	 dodoc COPYING CREDITS 
}


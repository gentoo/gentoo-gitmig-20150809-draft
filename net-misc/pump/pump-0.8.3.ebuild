# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/pump/pump-0.8.3.ebuild,v 1.2 2001/07/15 01:21:10 lamer Exp $
A=pump_0.8.3.orig.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="This is the DHCP/BOOTP client written by RedHat."
SRC_URI="http://ftp.debian.org/debian/pool/main/p/pump/${A}"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/p/pump/"
DEPEND=""

#RDEPEND=""

src_compile() {
	try make pump
}

src_install () {
	 dosbin pump
	 insinto /etc
	 doins ${FILESDIR}/pump.conf
	 doman pump.8
	 dodoc COPYING CREDITS 
}


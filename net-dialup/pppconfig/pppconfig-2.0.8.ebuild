# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppconfig/pppconfig-2.0.8.ebuild,v 1.1 2001/08/16 23:19:35 lamer Exp $
A=pppconfig_2.0.8.tar.gz
S=${WORKDIR}/pppconfig-2.1
DESCRIPTION="A text menu based utility for configuring ppp."
SRC_URI="http://ftp.debian.org/debian/pool/main/p/pppconfig/${A}"
HOMEPAGE="http://http://ftp.debian.org/debian/pool/main/p/pppconfig/"
DEPEND=">=net-dialup/ppp-2.4.1-r2
		 >=dev-util/dialog-0.7"

#RDEPEND=""

#src_compile() {
	#try emake
	#try make
#}

src_install () {
	 dodir /etc/chatscripts
	 dodir /etc/ppp/resolv
	 dosbin 0dns-down 0dns-up dns-clean
	 newsbin pppconfig pppconfig.real
	 dosbin ${FILESDIR}/pppconfig
	 doman pppconfig.8
	 dodoc debian/{copyright,README.debian,changelog}
}


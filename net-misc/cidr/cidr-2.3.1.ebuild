# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/cidr/cidr-2.3.1.ebuild,v 1.5 2002/08/01 11:40:16 seemant Exp $

A=cidr-current.tar.gz
S=${WORKDIR}/${PN}-2.3
DESCRIPTION="command line util to assist in calculating subnets."
SRC_URI="http://home.netcom.com/~naym/cidr/${A}"
HOMEPAGE="http://home.netcom.com/~naym/cidr/"
DEPEND=""
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

#RDEPEND=""

src_compile() {
	
	try make
}

src_install () {

	 dobin cidr	
	 dodoc README ChangeLog rfc1978.txt gpl.txt
	 doman cidr.1
}


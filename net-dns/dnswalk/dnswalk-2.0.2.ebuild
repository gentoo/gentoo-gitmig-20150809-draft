# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnswalk/dnswalk-2.0.2.ebuild,v 1.1 2002/06/29 00:55:03 bangert Exp $

S=${WORKDIR}
DESCRIPTION="dnswalk is a DNS database debugger"
SRC_URI="http://www.visi.com/~barr/dnswalk/${P}.tar.gz"
HOMEPAGE="http://www.visi.com/~barr/dnswalk/"

DEPEND=">=sys-devel/perl-5.6.1 >=dev-perl/Net-DNS-0.12"  
RDEPEND="${DEPEND}"

src_compile() {

	mv dnswalk dnswalk.orig
	sed 's/#!\/usr\/contrib\/bin\/perl/#!\/usr\/bin\/perl/' dnswalk.orig > dnswalk

}

src_install () {

	dobin dnswalk

	dodoc CHANGES README TODO do-dnswalk makereports sendreports rfc1912.txt dnswalk.errors
	doman dnswalk.1

}

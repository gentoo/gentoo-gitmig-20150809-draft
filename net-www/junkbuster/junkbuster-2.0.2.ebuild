# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/junkbuster/junkbuster-2.0.2.ebuild,v 1.2 2002/03/04 22:08:48 karltk Exp $

S=${WORKDIR}/ijb20
DESCRIPTION="Filtering HTTP proxy"
SRC_URI="http://www.waldherr.org/redhat/rpm/srpm/junkbuster-2.0.2-8.tar.gz"
HOMEPAGE="http://internet.junkbuster.com"

DEPEND="virtual/glibc"
RDEPEND="$DEPEND"

src_compile() {
	unset CXXFLAGS
	unset CFLAGS
	make || die
}

src_install () {
	dosbin junkbuster

	dodir /etc/init.d
	exeinto /etc/init.d
	newexe ${FILESDIR}/junkbuster.rc6 junkbuster

	dodir /etc/junkbuster
	insinto /etc/junkbuster
	doins blocklist config cookiefile forward imagelist
	
	dohtml gpl.html ijbman.html ijbfaq.html
	dodoc README README.TOO README.WIN squid.txt
	
	doman junkbuster.1
	
	dodir /var/log/junkbuster
}

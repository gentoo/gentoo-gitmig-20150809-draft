# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/junkbuster/junkbuster-2.0.2.ebuild,v 1.15 2004/07/21 20:38:50 mr_bones_ Exp $

DESCRIPTION="Filtering HTTP proxy"
HOMEPAGE="http://internet.junkbuster.com"
SRC_URI="http://www.waldherr.org/redhat/rpm/srpm/junkbuster-2.0.2-8.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/ijb20

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

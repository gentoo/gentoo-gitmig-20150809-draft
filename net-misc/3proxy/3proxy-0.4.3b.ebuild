# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/3proxy/3proxy-0.4.3b.ebuild,v 1.1 2004/03/18 04:13:54 vapier Exp $

DESCRIPTION="really tiny cross-platform proxy servers set"
HOMEPAGE="http://www.security.nnov.ru/soft/3proxy/"
SRC_URI="mirror://gentoo/${P}.tgz"
#http://www.security.nnov.ru/soft/3proxy/${PV}/3proxy.tgz

LICENSE="3proxy"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile.unix || die
	sed -i 's:/usr/local::' stringtable.c || die
}

src_compile() {
	emake -f Makefile.unix || die
}

src_install() {
	dobin 3proxy || die "dobin 3proxy failed"
	for bin in proxy socks pop3p tcppm udppm mycrypt dighosts ; do
		newbin ${bin} ${PN}-${bin} || die "newbin ${bin} failed"
	done
	chmod a-x 3proxy.cfg.sample Changelog Readme Release.notes
	dodoc 3proxy.cfg.sample Changelog Readme Release.notes
}

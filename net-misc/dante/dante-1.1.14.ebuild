# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dante/dante-1.1.14.ebuild,v 1.2 2003/09/05 22:01:48 msterret Exp $

inherit gcc

DESCRIPTION="A free socks4,5 and msproxy implemetation"
HOMEPAGE="http://www.inet.no/dante/"
SRC_URI="ftp://ftp.inet.no/pub/socks/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"
IUSE="tcpd debug"

DEPEND="virtual/glibc
	sys-libs/pam
	tcpd? ( sys-apps/tcp-wrappers )"

src_compile() {
	econf \
		`use_enable debug` \
		`use_enable tcpd libwrap` \
		--with-socks-conf=/etc/socks/socks.conf \
		--with-sockd-conf=/etc/socks/sockd.conf \
		${myconf} \
		|| die "bad ./configure"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die
	# Line 99 in socks.h conflicts with stuff in line 333 of
	# /usr/include/netinet/in.h this is a not-too-cool way of fix0ring that
	dosed "s:^int Rbindresvport://int Rbindresvport:" /usr/include/socks.h
	# bor: comment libdl.so out it seems to work just fine without it
	dosed 's:libdl\.so::' /usr/bin/socksify
	dodir /etc/socks
	dodoc BUGS CREDITS LICENSE NEWS README SUPPORT TODO VERSION
	docinto txt
	cd doc
	dodoc README* *.txt SOCKS4.*
	docinto example
	cd ../example
	dodoc *.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/dante-sockd-init dante-sockd
}

# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdnsd/pdnsd-1.1.6-r7.ebuild,v 1.2 2002/07/11 06:30:46 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Proxy DNS server with permanent caching"
SRC_URI="http://home.t-online.de/home/Moestl/${P}.tar.bz2"
HOMEPAGE="http://home.t-online.de/home/Moestl/"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {

	./configure \
	--prefix=/usr \
	--mandir=/usr/share/man \
	--sysconfdir=/etc/pdnsd \
	--with-cachedir=/var/lib/pdnsd \
	--host=${CHOST} || die "bad configure"

	emake all || die "compile problem"
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog* NEWS README THANKS TODO
	docinto contrib ; dodoc contrib/{README,dhcp2pdnsd,pdnsd_dhcp.pl}
	docinto html ; dodoc doc/html/*
	docinto txt ; dodoc doc/txt/*
	newdoc doc/pdnsd.conf pdnsd.conf.sample

	exeinto /etc/init.d ; newexe ${FILESDIR}/pdnsd.rc6 pdnsd
}

# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>, Parag Mehta <pm@gnuos.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/bind/bind-9.2.1.ebuild,v 1.1 2002/05/02 21:46:15 sandymac Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Bind - Name Server"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${A}"
HOMEPAGE="http://www.isc.org/products/BIND"
LICENSE="as-is"

DEPEND="virtual/glibc sys-apps/groff"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/doc/man
	#fix man pages to reflect Gentoo Linux file locations (drobbins)
	local x
	for x in */*
	do
		cp ${x} ${x}.orig
		sed -e 's:/etc/named.conf:/etc/bind/named.conf:g' -e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' ${x}.orig > ${x}
		rm ${x}.orig
	done
}

src_compile() {                           
	./configure --prefix=/usr --host=${CHOST} --sysconfdir=/etc/bind --localstatedir=/var --with-libtool || die
	make all || die
}

src_install() {
	make DESTDIR=${D} install || die
	doman doc/man/*/*.[1-8]

	dodoc CHANGES COPYRIGHT FAQ README
	docinto misc ; dodoc doc/misc/*
	docinto html ; dodoc doc/arm/*
	docinto contrib ; dodoc contrib/named-bootconf/named-bootconf.sh \
		contrib/nanny/nanny.pl

	# some handy-dandy dynamic dns examples
	cd ${D}/usr/share/doc/${PF}
	tar pjxf ${FILESDIR}/dyndns-samples.tbz2

	dodir /etc/bind /var/bind /var/bind/pri /var/bind/sec /var/run/named
	chown named.named ${D}/var/run/named
	chmod 0770 ${D}/var/run/named

	insinto /var/bind ; doins ${FILESDIR}/root.cache
	insinto /var/bind/pri ; doins ${FILESDIR}/localhost
	insinto /var/bind/pri ; doins ${FILESDIR}/127.0.0

	exeinto /etc/init.d ; newexe ${FILESDIR}/named.rc6 named
}

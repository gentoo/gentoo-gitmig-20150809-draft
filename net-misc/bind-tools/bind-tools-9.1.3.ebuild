# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>, Michael Nazaroff <naz@themoonsofjupiter.net>
# $Header: /var/cvsroot/gentoo-x86/net-misc/bind-tools/bind-tools-9.1.3.ebuild,v 1.1 2001/11/20 05:17:24 woodchip Exp $

P=bind-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="DNS querying tools from BIND: dig, host, and nslookup"
HOMEPAGE="http://www.isc.org/products/BIND/"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${P}.tar.gz"

DEPEND="virtual/glibc sys-devel/perl ssl? ( >=dev-libs/openssl-0.9.6 )"
RDEPEND="virtual/glibc"

src_compile() {

	# We just want host, dig and nslookup.  Nslookup is deprecated for dig
	# but its still around.  Adding -static to CFLAGS results in the
	# programs being built with the libdns and libisc stuff statically.
	# They're still dynamically linked with glibc.  Hopefully this avoids
	# any possible conflicts or problems with those libs being installed.

	local myconf
	use ssl && myconf="--with-openssl=/usr"

	export CFLAGS="${CFLAGS} -static"

	./configure \
	--with-libtool \
	--host=${CHOST} ${myconf} || die "bad configure"

	make depend || die "couldnt make depend"
	make -C lib/dns || die "problem in lib/dns"
	make -C lib/isc || die "problem in lib/isc"
	make -C bin/dig || die "problem in bin/dig"
}

src_install() {

	dobin  bin/dig/{dig,host,nslookup}
	doman  doc/man/bin/{dig,host}.1 ${FILESDIR}/nslookup.8
	dodoc  README CHANGES FAQ COPYRIGHT
}

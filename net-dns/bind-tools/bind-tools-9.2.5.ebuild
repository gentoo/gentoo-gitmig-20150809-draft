# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind-tools/bind-tools-9.2.5.ebuild,v 1.6 2005/04/06 10:07:32 kloeri Exp $

inherit flag-o-matic gnuconfig

MY_P=${P//-tools}
MY_P=${MY_P/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="bind tools: dig, nslookup, and host"
HOMEPAGE="http://www.isc.org/products/BIND/bind9.html"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV/_}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~arm hppa amd64 ~ia64 ~s390 ~mips ~ppc64"
IUSE="ipv6"

DEPEND="virtual/libc"

src_compile() {
	gnuconfig_update

	use ipv6 && myconf="${myconf} --enable-ipv6" || myconf="${myconf} --enable-ipv6=no"

	econf ${myconf} || die "Configure failed"

	export MAKEOPTS="${MAKEOPTS} -j1"

	cd ${S}/lib/isc
	emake || die "make failed in /lib/isc"

	cd ${S}/lib/dns
	emake || die "make failed in /lib/dns"

	cd ${S}/bin/dig
	emake || die "make failed in /bin/dig"

	cd ${S}/lib/lwres/
	emake || die "make failed in /lib/lwres"

	cd ${S}/bin/nsupdate/
	emake || die "make failed in /bin/nsupdate"
}

src_install() {
	dodoc README CHANGES FAQ

	cd ${S}/bin/dig
	dobin dig host nslookup || die
	doman dig.1 host.1 nslookup.1 || die

	cd ${S}/bin/nsupdate
	dobin nsupdate || die
	doman nsupdate.8 || die
	dohtml nsupdate.html || die
}

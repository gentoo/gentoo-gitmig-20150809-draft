# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdnsd/pdnsd-1.1.9.ebuild,v 1.1 2004/02/02 16:59:39 dragonheart Exp $

DESCRIPTION="Proxy DNS server with permanent caching"

MY_P=${PN}-${PV}-par

SRC_URI="http://www.phys.uu.nl/%7Erombouts/pdnsd/${MY_P}.tar.gz"

HOMEPAGE="http://home.t-online.de/home/Moestl http://www.phys.uu.nl/%7Erombouts/pdnsd.html"

IUSE="ipv6 debug isdn"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="BSD | GPL-2"

# Should work on ppc and sparc, (alpha?)
KEYWORDS="~x86"

S=${WORKDIR}/${PN}-${PV}


# for debugging use
use debug && RESTRICT="${RESTRICT} nostrip"

src_compile() {
	cd ${S} || die
	local myconf

	if [ `use debug` ]; then
	 	myconf="${myconf} --with-debug=3"
		CFLAGS="${CFLAGS} -g"
	fi
	[ -c /dev/urandom ] && myconf="${myconf} --with-random-device=/dev/urandom"

	econf \
		--sysconfdir=/etc/pdnsd \
		--with-cachedir=/var/lib/pdnsd \
		--infodir=/usr/share/info --mandir=/usr/share/man \
		`use_enable ipv6` `use_enable isdn` \
		${myconf} \
		|| die "bad configure"

	emake all || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	enewgroup pdnsd
	enewuser pdnsd -1 /bin/false /var/lib/pdnsd pdnsd
	fowners pdnsd:pdnsd /var/lib/pdnsd /var/lib/pdnsd/pdnsd.cache

	sed -i 's/run_as=.*/run_as="pdnsd";/' ${D}/etc/pdnsd/pdnsd.conf.sample

	dodoc AUTHORS COPYING* ChangeLog* NEWS README THANKS TODO README.par
	docinto contrib ; dodoc contrib/{README,dhcp2pdnsd,pdnsd_dhcp.pl}
	docinto html ; dohtml doc/html/*
	docinto txt ; dodoc doc/txt/*
	newdoc doc/pdnsd.conf pdnsd.conf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/pdnsd.rc6 pdnsd
	newexe ${FILESDIR}/pdnsd.online pdnsd-online

	[ `use ipv6` ] && \
		sed -i "s:-- -s:-- -6 -s:" ${D}/etc/init.d/pdnsd

	[ `use ipv6` ] && \
		ewarn "make sure your servers in /etc/pdnsd/pdnsd.conf are reachable with IPv6"

	keepdir /etc/conf.d
	local config=${D}/etc/conf.d/pdnsd-online
	echo "# Enter the interface that connects you to the dns servers" > ${config}
	echo "# This will correspond to /etc/init.d/net.${IFACE}" >> ${config}
	echo "IFACE=ppp0" >> ${config}

	einfo "Add pdnsd to your default runlevel."
	einfo ""
	einfo "Add pdnsd-online to your online runlevel."
	einfo "The online interface will be listed in /etc/conf.d/pdnsd-online"
}

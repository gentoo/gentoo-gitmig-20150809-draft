# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdnsd/pdnsd-1.1.10.ebuild,v 1.1 2004/02/22 08:20:03 dragonheart Exp $

DESCRIPTION="Proxy DNS server with permanent caching"

MY_P=${PN}-${PV}-par

SRC_URI="http://www.phys.uu.nl/%7Erombouts/pdnsd/${MY_P}.tar.gz"

HOMEPAGE="http://www.phys.uu.nl/%7Erombouts/pdnsd.html http://home.t-online.de/home/Moestl"

IUSE="ipv6 debug isdn"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="BSD | GPL-2"

# Should work on  alpha arm hppa i386 ia64 m68k mips mipsel powerpc s390 sparc 
# REF http://packages.debian.org/cgi-bin/search_packages.pl?searchon=names&version=all&exact=1&keywords=pdnsd

KEYWORDS="~x86 ~ppc ~sparc"

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
		--with-cachedir=/var/cache/pdnsd \
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

	# Copy cache from prev versions
	[ -f /var/lib/pdnsd/pdnsd.cache ] && cp /var/lib/pdnsd/pdnsd.cache ${D}/var/cache/pdnsd/pdnsd.cache

	# Don't clobber existing cache
	[ -f /var/cache/pdnsd/pdnsd.cache ] && rm ${D}/var/cache/pdnsd/pdnsd.cache

	fowners pdnsd:pdnsd /var/cache/pdnsd

	[ -f ${D}/var/cache/pdnsd/pdnsd.cache ] fowners pdnsd:pdnsd /var/cache/pdnsd/pdnsd.cache

	sed -i 's/run_as=.*/run_as="pdnsd";/' ${D}/etc/pdnsd/pdnsd.conf.sample

	dodoc AUTHORS COPYING* ChangeLog* NEWS README THANKS TODO README.par
	docinto contrib ; dodoc contrib/{README,dhcp2pdnsd,pdnsd_dhcp.pl}
	docinto html ; dohtml doc/html/*
	docinto txt ; dodoc doc/txt/*
	newdoc doc/pdnsd.conf pdnsd.conf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/pdnsd.rc6 pdnsd
	newexe ${FILESDIR}/pdnsd.online pdnsd-online

	use ipv6 && \
		ewarn "make sure your servers in /etc/pdnsd/pdnsd.conf are reachable with IPv6"

	keepdir /etc/conf.d
	local config=${D}/etc/conf.d/pdnsd-online
	echo "# Enter the interface that connects you to the dns servers" > ${config}
	echo "# This will correspond to /etc/init.d/net.${IFACE}" >> ${config}
	echo "IFACE=ppp0" >> ${config}
	use ipv6 && echo PDNSDCONFIG="-6" >> ${config} \
		|| echo PDNSDCONFIG="" >> ${config}

	${D}/usr/sbin/pdnsd --help | sed "s/^/# /g" >> ${config}

	einfo "Add pdnsd to your default runlevel."
	einfo ""
	einfo "Add pdnsd-online to your online runlevel."
	einfo "The online interface will be listed in /etc/conf.d/pdnsd-online"
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdnsd/pdnsd-1.1.10.ebuild,v 1.19 2004/11/08 08:55:06 mr_bones_ Exp $

inherit eutils

MY_P=${PN}-${PV}-par
DESCRIPTION="Proxy DNS server with permanent caching"
HOMEPAGE="http://www.phys.uu.nl/%7Erombouts/pdnsd.html http://home.t-online.de/home/Moestl"
SRC_URI="http://www.phys.uu.nl/%7Erombouts/pdnsd/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc s390 sparc x86"
IUSE="ipv6 debug isdn"

DEPEND="virtual/libc
	sys-apps/sed
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	sys-devel/automake
	sys-devel/autoconf"
RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}-${PV}

pkg_setup() {
	enewgroup pdnsd
	enewuser pdnsd -1 /bin/false /var/lib/pdnsd pdnsd
}

src_compile() {
	cd ${S} || die
	local myconf

	if use debug; then
	 	myconf="${myconf} --with-debug=3"
		CFLAGS="${CFLAGS} -g"
	fi
	[ -c /dev/urandom ] && myconf="${myconf} --with-random-device=/dev/urandom"

	econf \
		--sysconfdir=/etc/pdnsd \
		--with-cachedir=/var/cache/pdnsd \
		--infodir=/usr/share/info --mandir=/usr/share/man \
		--with-default-id=pdnsd \
		`use_enable ipv6` `use_enable isdn` \
		${myconf} \
		|| die "bad configure"

	emake all || die "compile problem"
}

pkg_preinst() {
	enewgroup pdnsd
	enewuser pdnsd -1 /bin/false /var/lib/pdnsd pdnsd
}

src_install() {

	emake DESTDIR=${D} install || die

	# Copy cache from prev versions
	[ -f ${ROOT}/var/lib/pdnsd/pdnsd.cache ] && \
		cp ${ROOT}/var/lib/pdnsd/pdnsd.cache ${D}/var/cache/pdnsd/pdnsd.cache

	# Don't clobber existing cache - copy prev cache so unmerging prev version
	# doesn't remove the cache.
	[ -f ${ROOT}/var/cache/pdnsd/pdnsd.cache ] && \
		cp ${ROOT}/var/cache/pdnsd/pdnsd.cache ${D}/var/cache/pdnsd/pdnsd.cache

	dodoc AUTHORS COPYING* ChangeLog* NEWS README THANKS TODO README.par
	docinto contrib ; dodoc contrib/{README,dhcp2pdnsd,pdnsd_dhcp.pl}
	docinto html ; dohtml doc/html/*
	docinto txt ; dodoc doc/txt/*
	newdoc doc/pdnsd.conf pdnsd.conf.sample

	# Remind users that the cachedir has moved to /var/cache
	#[ -f ${ROOT}/etc/pdnsd/pdnsd.conf ] && \
	#	sed -e "s#/var/lib#/var/cache#g" ${ROOT}/etc/pdnsd/pdnsd.conf \
	#	> ${D}/etc/pdnsd/pdnsd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/pdnsd.rc6 pdnsd
	newexe ${FILESDIR}/pdnsd.online pdnsd-online

	use ipv6 && \
		ewarn "make sure your servers in /etc/pdnsd/pdnsd.conf are reachable with IPv6"

	keepdir /etc/conf.d
	local config=${D}/etc/conf.d/pdnsd-online

	${D}/usr/sbin/pdnsd --help | sed "s/^/# /g" > ${config}
	echo -e "\n\n# Enter the interface that connects you to the dns servers" >> ${config}
	echo "# This will correspond to /etc/init.d/net.${IFACE}" >> ${config}
	echo -e "\n# IMPORTANT: Be sure to run depscan.sh after modifiying IFACE" >>  ${config}
	echo "IFACE=ppp0" >> ${config}
	echo "# Command line options" >> ${config}
	use ipv6 && echo PDNSDCONFIG="-6" >> ${config} \
		|| echo PDNSDCONFIG="" >> ${config}

}

pkg_postinst() {
	einfo
	einfo "Add pdnsd to your default runlevel - rc-update add pdnsd default"
	einfo ""
	einfo "Add pdnsd-online to your online runlevel."
	einfo "The online interface will be listed in /etc/conf.d/pdnsd-online"
	einfo ""
	einfo "Sample config file in /etc/pdnsd/pdnsd.conf.sample"

}

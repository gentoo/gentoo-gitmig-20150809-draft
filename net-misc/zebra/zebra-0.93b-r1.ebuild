# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zebra/zebra-0.93b-r1.ebuild,v 1.12 2004/11/30 22:28:17 swegener Exp $

inherit eutils

IUSE="pam snmp ipv6 ospfapi"

DESCRIPTION="Multithreaded TCP/IP Routing Software that supports BGP-4, RIPv1, RIPv2 and OSPFv2. Includes OSPFAPI"
SRC_URI="ftp://ftp.zebra.org/pub/zebra/${P}.tar.gz \
		ospfapi? ( http://www.tik.ee.ethz.ch/~keller/ospfapi/src/ospfapi-release_0_93b-2003-01-25.tar.gz )"

HOMEPAGE="http://www.zebra.org"
# Homepage for ospfapi
HOMEPAGE="${HOMEPAGE} http://www.tik.ee.ethz.ch/~keller/ospfapi"
KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	sys-devel/binutils
	pam? ( >=sys-libs/pam-0.75-r11 )
	snmp? ( virtual/snmp )"

RDEPEND="virtual/libc sys-devel/binutils"

src_unpack() {
	unpack ${A} || die
	cd ${WORKDIR}
	ln -s ${S} zebra

	use ospfapi &&
	 	epatch ospfapi-release_*-200[3-9]-[0-9][0-9]-[0-9][0-9].patch

	##################################
	# This fix is for zebra-0.93b only
	##################################
	cd ${S}/ospfd || die
	epatch ${FILESDIR}/${P}/ospfd-assert-fix.patch
	epatch ${FILESDIR}/${P}/ospfd-nbr-fix.patch
	##################################
}

src_compile() {
	local myconf="--enable-vtysh --enable-tcp-zebra"

	# use libpam for PAM support in vtysh
	use  pam && myconf="${myconf} --with-libpam" || myconf="${myconf} --disable-pam"
	use snmp && myconf="${myconf} --enable-snmp" || myconf="${myconf} --disable-snmp"
	use ipv6 && myconf="${myconf} --enable-ipv6" || myconf="${myconf} --disable-ipv6"

	use ospfapi && myconf="${myconf} --enable-opaque-lsa --enable-ospf-te \
		--enable-nssa"
	use ospfapi && ./update-autotools

	econf --prefix=/usr --sysconfdir=/etc/zebra ${myconf} || \
		die "econf failed"
	emake || die "emake failed"

	if use ospfapi  ; then
		cd apiclient
		econf --prefix=/usr --sysconfdir=/etc/zebra ${myconf} || \
			die "econf failed in ospsapi-apiclient"
		emake || die "emake failed in ospsapi-apiclient"
		cd ..
	fi
}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/zebra \
		localstatedir=${D}/var \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die "zebra installation failed"

	mkdir -p ${D}/etc/zebra/sample
	# dodir ${D}/etc/ {D}/etc/zebra/ ${D}/etc/zebra/sample
	cp */*.conf.sample* ${D}/etc/zebra/
	mv ${D}/etc/zebra/*.conf.sample* ${D}/etc/zebra/sample

	for proto in zebra bgpd ospfd ripd; do
		insinto /etc/conf.d
		newins ${FILESDIR}/conf.d/${proto}.confd ${proto}
		exeinto /etc/init.d
		newexe ${FILESDIR}/init.d/${proto}.initd ${proto}
	done

	# second loop for ipv6
	use ipv6 && for proto in ospf6d ripngd; do
		insinto /etc/conf.d
		newins ${FILESDIR}/conf.d/${proto}.confd ${proto}
		exeinto /etc/init.d
		newexe ${FILESDIR}/init.d/${proto}.initd ${proto}
	done

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README REPORTING-BUGS SERVICES TODO
}

pkg_postinst() {
	einfo "Sample configuration files can be found in /etc/zebra/sample"
	einfo "You have to create config files in /etc/zebra before"
	einfo "starting any one of the daemons."
}

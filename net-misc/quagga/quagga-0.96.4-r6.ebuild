# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.96.4-r6.ebuild,v 1.9 2005/03/20 18:09:43 mrness Exp $

inherit eutils

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP. Includes OSPFAPI, NET-SNMP and IPV6 support."
HOMEPAGE="http://quagga.net/"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
SLOT="0"
LICENSE="GPL-2"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz"
IUSE="ipv6 snmp pam"

DEPEND="virtual/libc
	sys-devel/binutils
	>=sys-libs/libcap-1.10-r3
	!sys-apps/zebra
	!sys-apps/zebra-ag-svn
	!sys-apps/zebra-pj-cvs
	!sys-apps/quagga-ag-svn-HEAD
	!sys-apps/quagga-svn-HEAD"

[ -z "${QUAGGA_GROUP_GID}" ] && QUAGGA_GROUP_GID=441
[ -z "${QUAGGA_GROUP_NAME}" ] && QUAGGA_GROUP_NAME="quagga"
[ -z "${QUAGGA_USER_NAME}" ] && QUAGGA_USER_NAME="quagga"
[ -z "${QUAGGA_USER_UID}" ] && QUAGGA_USER_UID=441
[ -z "${QUAGGA_USER_SH}" ] && QUAGGA_USER_SH="/bin/false"
[ -z "${QUAGGA_USER_HOMEDIR}" ] && QUAGGA_USER_HOMEDIR=/var/empty
[ -z "${QUAGGA_USER_GROUPS}" ] && QUAGGA_USER_GROUPS=${QUAGGA_GROUP_NAME}

pkg_preinst() {
	enewgroup ${QUAGGA_GROUP_NAME} ${QUAGGA_GROUP_GID}
	enewuser ${QUAGGA_USER_NAME} ${QUAGGA_USER_UID} ${QUAGGA_USER_SH} ${QUAGGA_USER_HOMEDIR} ${QUAGGA_USER_GROUPS}
}

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/patches-${PV}/opaque-ready.patch
	epatch ${FILESDIR}/patches-${PV}/ospf_refcount.patch
}

src_compile() {
	local ipv
	local snmp
	local pam

	use ipv6 && ipv="--enable-ipv6 --enable-ripng --enable-ospf6d --enable-rtadv" || ipv="--disable-ipv6 --disable-ripngd --disable-ospf6d"
	use snmp && snmp="--enable-snmp"
	use pam && pam="--with-libpam"

	# update makefiles

	export WANT_AUTOMAKE=1.7

	./update-autotools || die

	#
	# ipforward detection is broken (and usersandbox will break it too)
	# thanks to Merlin from irc://irc.freenode.net/#quagga
	#
	export IPFORWARD=ipforward_proc.o
	export zebra_ipforward_path="proc"

	# configure the stuff

	./configure --host=${CHOST} --prefix=/usr --enable-tcp-zebra \
	            --enable-nssa --enable-opaque-lsa --enable-ospf-te \
		    --enable-ospf-secondary \
		    --enable-user=${QUAGGA_USER} \
		    --enable-group=${QUAGGA_GROUP} \
		    --enable-vty-group=${QUAGGA_VTYGROUP} \
		    --with-cflags="${CFLAGS}" \
	            --enable-vtysh ${ipv} ${snmp} ${pam} \
		    --sysconfdir=/etc/quagga \
		    --includedir=${D}/usr/include/quagga \
		    --libdir=${D}/usr/lib/quagga \
			|| die
	emake || die
}

src_install() {
	einstall || die

	dodir /etc/quagga || die
	dodir /etc/quagga/sample || die
	mv ${D}/etc/*sample* ${D}/etc/quagga/sample || die

	keepdir /var/run/quagga || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/init/zebra zebra || die
	newexe ${FILESDIR}/init/ripd ripd || die
	newexe ${FILESDIR}/init/ospfd ospfd || die
	newexe ${FILESDIR}/init/bgpd bgpd || die

	use ipv6 && ( newexe ${FILESDIR}/init/ripngd ripngd )
	use ipv6 && ( newexe ${FILESDIR}/init/ospf6d ospf6d )
}

pkg_postinst() {
	# empty dir for pid files for the new priv separation auth
	#set proper owner/group/perms even if dir already existed
	install -d -m0700 -o ${QUAGGA_USER_NAME} -g ${QUAGGA_GROUP_NAME} ${ROOT}/etc/quagga
	install -d -m0755 -o ${QUAGGA_USER_NAME} -g ${QUAGGA_GROUP_NAME} ${ROOT}/var/run/quagga

	einfo "Sample configuration files can be found in /etc/quagga/sample."
	einfo "You have to create config files in /etc/quagga before"
	einfo "starting one of the daemons."
}

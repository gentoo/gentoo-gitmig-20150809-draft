# Copyright 1999-2004 Gentoo Foundation
# Copyright 2003-2004 DataCore GmbH
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.97.2.ebuild,v 1.2 2004/11/02 23:40:23 vapier Exp $

inherit eutils

MD5_PATCH="ht-20040525-0.96.5-bgp-md5.patch"

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP. Includes OSPFAPI, NET-SNMP and IPV6 support."
HOMEPAGE="http://quagga.net/"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz
	tcpmd5? ( http://hasso.linux.ee/quagga/$MD5_PATCH )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="ipv6 snmp pam tcpmd5 ospfapi"

RDEPEND="sys-apps/iproute2
	=sys-libs/libcap-1.10-r3
	!sys-apps/zebra
	!sys-apps/zebra-ag-svn
	!sys-apps/zebra-pj-cvs
	!sys-apps/quagga-ag-svn-HEAD
	!sys-apps/quagga-svn-HEAD"
DEPEND="${RDEPEND}
	virtual/libc
	sys-devel/binutils"

[ -z "${QUAGGA_USER_NAME}" ] && QUAGGA_USER_NAME="quagga"
[ -z "${QUAGGA_USER_UID}" ] && QUAGGA_USER_UID=441
[ -z "${QUAGGA_GROUP_NAME}" ] && QUAGGA_GROUP_NAME="quagga"
[ -z "${QUAGGA_GROUP_GID}" ] && QUAGGA_GROUP_GID=441
[ -z "${QUAGGA_VTYGROUP}" ] && QUAGGA_VTYGROUP="quagga"
[ -z "${QUAGGA_USER_SH}" ] && QUAGGA_USER_SH="/bin/false"
[ -z "${QUAGGA_USER_HOMEDIR}" ] && QUAGGA_USER_HOMEDIR=/var/empty
[ -z "${QUAGGA_USER_GROUPS}" ] && QUAGGA_USER_GROUPS=${QUAGGA_GROUP_NAME}
[ -z "${QUAGGA_STATEDIR}" ] && QUAGGA_STATEDIR=/var/run/quagga

pkg_preinst() {
	enewgroup ${QUAGGA_GROUP_NAME} ${QUAGGA_GROUP_GID}
	enewuser ${QUAGGA_USER_NAME} ${QUAGGA_USER_UID} ${QUAGGA_USER_SH} ${QUAGGA_USER_HOMEDIR} ${QUAGGA_USER_GROUPS}
}

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	[ -d ${FILESDIR}/patches-${PV} ] && epatch ${FILESDIR}/patches-${PV}
}

src_compile() {
	local ipv
	local snmp
	local pam
	local tcpmd5
	local ospfapi

	use ipv6 && ipv="--enable-ipv6 --enable-ripng --enable-ospf6d --enable-rtadv" || ipv="--disable-ipv6 --disable-ripngd --disable-ospf6d"
	use snmp && snmp="--enable-snmp"
	use pam && pam="--with-libpam"

	use tcpmd5 && tcpmd5="--enable-tcp-md5"
	use tcpmd5 && epatch ${DISTDIR}/$MD5_PATCH

	use ospfapi && ospfapi="--enable-opaque-lsa --enable-ospf-te --enable-ospfclient"

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

	./configure --host=${HOST} \
		    --prefix=${D}/usr \
		    --enable-tcp-zebra \
	            --enable-nssa \
		    --enable-user=${QUAGGA_USER} \
		    --enable-group=${QUAGGA_GROUP} \
		    --enable-vty-group=${QUAGGA_VTYGROUP} \
		    --with-cflags="${CFLAGS}" \
	            --enable-vtysh ${ipv} ${snmp} ${pam} ${tcpmd5} ${ospfapi} \
		    --sysconfdir=/etc/quagga \
		    --enable-exampledir=${D}/etc/quagga/samples \
		    --includedir=${D}/usr/include \
		    --localstatedir=${QUAGGA_STATEDIR} \
		    --libdir=${D}/usr/lib/quagga \
			|| die
	emake || die
}

src_install() {
	einstall || die

	dodir /etc/quagga || die
	dodir /etc/quagga/samples || die

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
	install -d -m0755 -o quagga -g quagga ${ROOT}/var/run/quagga

	einfo "Sample configuration files can be found in /etc/quagga/sample."
	einfo "You have to create config files in /etc/quagga before"
	einfo "starting one of the daemons."
}

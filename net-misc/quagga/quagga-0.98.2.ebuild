# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.98.2.ebuild,v 1.4 2005/04/01 17:20:16 mrness Exp $

inherit eutils

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP. Includes OSPFAPI, NET-SNMP and IPV6 support."
HOMEPAGE="http://quagga.net/"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~ppc ~sparc x86"
IUSE="ipv6 snmp pam tcpmd5 bgpclassless ospfapi"

RDEPEND="!net-misc/zebra
	sys-apps/iproute2
	sys-libs/libcap
	snmp? ( net-analyzer/net-snmp )
	pam? ( sys-libs/pam )"
DEPEND="${RDEPEND}
	virtual/libc
	sys-devel/binutils"

# TCP MD5 for BGP patch for Linux (RFC 2385) 
MD5_PATCH="ht-20050110-0.98.0-bgp-md5.patch"
# http://hasso.linux.ee/quagga/ht-20050110-0.98.0-bgp-md5.patch

# Classless prefixes for BGP
CLASSLESS_PATCH="ht-20040304-classless-bgp.patch"
# http://hasso.linux.ee/quagga/pending-patches/ht-20040304-classless-bgp.patch

# Connected route fix (Amir)
CONNECTED_PATCH="amir-connected-route.patch"
# http://voidptr.sboost.org/quagga/amir-connected-route.patch.bz2

[ -z "${QUAGGA_USER_NAME}" ] && QUAGGA_USER_NAME="quagga"
[ -z "${QUAGGA_USER_UID}" ] && QUAGGA_USER_UID="-1"
[ -z "${QUAGGA_GROUP_NAME}" ] && QUAGGA_GROUP_NAME="quagga"
#[ -z "${QUAGGA_GROUP_GID}" ] && QUAGGA_GROUP_GID=""
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
	unpack ${A} || die "failed to unpack sources"

	cd ${S} || die "source dir not found"
	use tcpmd5 && epatch ${FILESDIR}/patches-${PV}/${MD5_PATCH}
	use bgpclassless && epatch ${FILESDIR}/patches-${PV}/${CLASSLESS_PATCH}
	# non-upstream connected route patch
	epatch ${FILESDIR}/patches-${PV}/${CONNECTED_PATCH}
}

src_compile() {
	# regenerate configure and co if we touch .ac or .am files
	#export WANT_AUTOMAKE=1.7
	#./update-autotools || die
	autoreconf
	libtoolize --copy --force

	local myconf="--disable-static --enable-dynamic"

	use ipv6 \
			&& myconf="${myconf} --enable-ipv6 --enable-ripng --enable-ospf6d --enable-rtadv" \
			|| myconf="${myconf} --disable-ipv6 --disable-ripngd --disable-ospf6d"
	use ospfapi \
			&& myconf="${myconf} --enable-opaque-lsa --enable-ospf-te --enable-ospfclient"
	use snmp && myconf="${myconf} --enable-snmp"
	use pam && myconf="${myconf} --with-libpam"
	use tcpmd5 && myconf="${myconf} --enable-tcp-md5"

	econf \
		--enable-tcp-zebra \
		--enable-nssa \
		--enable-user=${QUAGGA_USER_NAME} \
		--enable-group=${QUAGGA_GROUP_NAME} \
		--enable-vty-group=${QUAGGA_VTYGROUP} \
		--with-cflags="${CFLAGS}" \
		--enable-vtysh \
		--sysconfdir=/etc/quagga \
		--enable-exampledir=/etc/quagga/samples \
		--localstatedir=${QUAGGA_STATEDIR} \
		--libdir=/usr/lib/quagga \
		${myconf} \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall \
		localstatedir=${D}/${QUAGGA_STATEDIR} \
		sysconfdir=${D}/etc/quagga \
		exampledir=${D}/etc/quagga/samples \
		libdir=${D}/usr/lib/quagga || die "make install failed"

	keepdir /var/run/quagga || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/init/zebra zebra && \
		newexe ${FILESDIR}/init/ripd ripd && \
		newexe ${FILESDIR}/init/ospfd ospfd && \
		( ! use ipv6 || newexe ${FILESDIR}/init/ripngd ripngd ) && \
		( ! use ipv6 || newexe ${FILESDIR}/init/ospf6d ospf6d ) && \
		newexe ${FILESDIR}/init/bgpd bgpd || die "failed to install init scripts"

	if use pam; then
		insinto /etc/pam.d
		newins ${FILESDIR}/quagga.pam quagga
	fi

	newenvd ${FILESDIR}/quagga.env 99quagga
}

pkg_postinst() {
	# empty dir for pid files for the new priv separation auth
	#set proper owner/group/perms even if dir already existed
	install -d -m0770 -o root -g ${QUAGGA_GROUP_NAME} ${ROOT}/etc/quagga
	install -d -m0755 -o ${QUAGGA_USER_NAME} -g ${QUAGGA_GROUP_NAME} ${ROOT}/var/run/quagga

	einfo "Sample configuration files can be found in /etc/quagga/sample."
	einfo "You have to create config files in /etc/quagga before"
	einfo "starting one of the daemons."
}

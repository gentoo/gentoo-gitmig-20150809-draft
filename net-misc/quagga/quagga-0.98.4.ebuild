# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.98.4.ebuild,v 1.1 2005/08/11 09:01:32 mrness Exp $

inherit eutils

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP. Includes OSPFAPI, NET-SNMP and IPV6 support."
HOMEPAGE="http://quagga.net/"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz
	mirror://gentoo/${P}-patches-20050811.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="ipv6 snmp pam tcpmd5 bgpclassless ospfapi realms"

RDEPEND="sys-apps/iproute2
	sys-libs/libcap
	snmp? ( net-analyzer/net-snmp )
	pam? ( sys-libs/pam )"
DEPEND="${RDEPEND}
	virtual/libc
	sys-devel/binutils"

src_unpack() {
	unpack ${A} || die "failed to unpack sources"

	cd ${S} || die "source dir not found"
	# TCP MD5 for BGP patch for Linux (RFC 2385) - http://hasso.linux.ee/quagga/ht-20050110-0.98.0-bgp-md5.patch
	use tcpmd5 && epatch "${WORKDIR}/patch/ht-20050110-0.98.0-bgp-md5.patch"
	# Classless prefixes for BGP - http://hasso.linux.ee/quagga/pending-patches/ht-20040304-classless-bgp.patch
	use bgpclassless && epatch "${WORKDIR}/patch/ht-20040304-classless-bgp.patch"
	# Connected route fix (Amir) - http://voidptr.sboost.org/quagga/amir-connected-route.patch.bz2
	epatch "${WORKDIR}/patch/amir-connected-route.patch"
	# Realms support (Calin Velea) - http://vcalinus.gemenii.ro/quaggarealms.html
	use realms && epatch "${WORKDIR}/patch/${P}-realms.diff"
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
	use realms && myconf="${myconf} --enable-realms"

	econf \
		--enable-tcp-zebra \
		--enable-nssa \
		--enable-user=quagga \
		--enable-group=quagga \
		--enable-vty-group=quagga \
		--with-cflags="${CFLAGS}" \
		--enable-vtysh \
		--sysconfdir=/etc/quagga \
		--enable-exampledir=/etc/quagga/samples \
		--localstatedir=/var/run/quagga \
		--libdir=/usr/lib/quagga \
		${myconf} \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall \
		localstatedir=${D}/var/run/quagga \
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

pkg_preinst() {
	enewgroup quagga
	enewuser quagga -1 -1 /var/empty quagga
}

pkg_postinst() {
	# empty dir for pid files for the new priv separation auth
	#set proper owner/group/perms even if dir already existed
	install -d -m0770 -o root -g quagga ${ROOT}/etc/quagga
	install -d -m0755 -o quagga -g quagga ${ROOT}/var/run/quagga

	einfo "Sample configuration files can be found in /etc/quagga/samples."
	einfo "You have to create config files in /etc/quagga before"
	einfo "starting one of the daemons."

	if use ipv6; then
		echo
		ewarn "This version of quagga contains a netlink race condition fix that triggered a kernel bug"
		ewarn "which affects IPv6 users who have a kernel version < 2.6.13-rc6."
		ewarn "See following links for more info:"
		ewarn "   http://lists.quagga.net/pipermail/quagga-dev/2005-June/003507.html"
		ewarn "   http://bugzilla.quagga.net/show_bug.cgi?id=196"
	fi
}

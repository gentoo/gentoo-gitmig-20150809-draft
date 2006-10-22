# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.99.5.ebuild,v 1.1 2006/10/22 20:03:21 mrness Exp $

inherit eutils multilib autotools

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP. Includes OSPFAPI, NET-SNMP and IPV6 support."
HOMEPAGE="http://quagga.net/"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz
	mirror://gentoo/${P}-patches-20061022.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="ipv6 snmp pam tcpmd5 bgpclassless ospfapi realms multipath tcp-zebra"
RESTRICT="userpriv"

DEPEND=">=sys-libs/libcap-1.10-r5
	snmp? ( net-analyzer/net-snmp )
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

src_unpack() {
	unpack ${A} || die "failed to unpack sources"

	cd "${S}" || die "source dir not found"
	epatch "${WORKDIR}/patch/${P}-zebra-linkorder.patch"

	# TCP MD5 for BGP patch for Linux (RFC 2385) - http://hasso.linux.ee/doku.php/english:network:rfc2385
	use tcpmd5 && epatch "${WORKDIR}/patch/ht-20050321-0.98.2-bgp-md5_adapted.patch"

	# Classless prefixes for BGP - http://hasso.linux.ee/doku.php/english:network:quagga
	use bgpclassless && epatch "${WORKDIR}/patch/ht-20040304-classless-bgp_adapted.patch"

	# Realms support (Calin Velea) - http://vcalinus.gemenii.ro/quaggarealms.html
	use realms && epatch "${WORKDIR}/patch/${P}-realms.diff"

	eautoreconf
}

src_compile() {
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
	use multipath && myconf="${myconf} --enable-multipath=0"
	use tcp-zebra && myconf="${myconf} --enable-tcp-zebra"

	econf \
		--enable-nssa \
		--enable-user=quagga \
		--enable-group=quagga \
		--enable-vty-group=quagga \
		--with-cflags="${CFLAGS}" \
		--enable-vtysh \
		--sysconfdir=/etc/quagga \
		--enable-exampledir=/etc/quagga/samples \
		--localstatedir=/var/run/quagga \
		--libdir=/usr/$(get_libdir)/quagga \
		${myconf} \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall \
		localstatedir="${D}/var/run/quagga" \
		sysconfdir="${D}/etc/quagga" \
		exampledir="${D}/etc/quagga/samples" \
		libdir="${D}/usr/$(get_libdir)/quagga" || die "make install failed"

	keepdir /var/run/quagga

	local i MY_SERVICES_LIST="zebra ripd ospfd bgpd"
	use ipv6 && MY_SERVICES_LIST="${MY_SERVICES_LIST} ripngd ospf6d"
	for i in ${MY_SERVICES_LIST} ; do
		newinitd "${FILESDIR}/${i}.init" ${i} || die "failed to install ${i} init.d script"
	done
	newconfd "${FILESDIR}/zebra.conf" zebra || die "failed to install zebra conf.d script"

	if use pam; then
		insinto /etc/pam.d
		newins "${FILESDIR}/quagga.pam" quagga
	fi

	newenvd "${FILESDIR}/quagga.env" 99quagga
}

pkg_preinst() {
	enewgroup quagga
	enewuser quagga -1 -1 /var/empty quagga
}

pkg_postinst() {
	# empty dir for pid files for the new priv separation auth
	#set proper owner/group/perms even if dir already existed
	install -d -m0770 -o root -g quagga "${ROOT}/etc/quagga"
	install -d -m0755 -o quagga -g quagga "${ROOT}/var/run/quagga"

	einfo "Sample configuration files can be found in /etc/quagga/samples."
	einfo "You have to create config files in /etc/quagga before"
	einfo "starting one of the daemons."

	if use tcpmd5; then
		echo
		ewarn "TCP MD5 for BGP needs a patched kernel!"
		ewarn "See http://hasso.linux.ee/doku.php/english:network:rfc2385 for more info."
	fi
}

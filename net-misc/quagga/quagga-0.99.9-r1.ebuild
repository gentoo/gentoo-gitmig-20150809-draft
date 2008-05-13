# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.99.9-r1.ebuild,v 1.3 2008/05/13 22:38:28 mrness Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils multilib autotools linux-info

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP."
HOMEPAGE="http://quagga.net/"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz
	mirror://gentoo/${P}-patches-20070913.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="caps ipv6 snmp pam tcpmd5 bgpas4 bgpclassless ospfapi realms multipath tcp-zebra"
RESTRICT="userpriv"

DEPEND="sys-libs/readline
	caps? ( >=sys-libs/libcap-1.10-r9 )
	snmp? ( net-analyzer/net-snmp )
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

pkg_setup() {
	if use tcpmd5 ; then
		get_version || get_running_version
	fi
	return 0
}

src_unpack() {
	unpack ${A}

	cd "${S}" || die "source dir not found"
	epatch "${WORKDIR}/patch/${P}-link-libcap.patch"

	# AS4 support (original found at http://quagga.ncc.eurodata.de)
	use bgpas4 && epatch "${WORKDIR}/patch/quagga-cvs20070909-as4-v09.patch"

	if use tcpmd5 ; then
		if kernel_is lt 2 6 20 ; then
			# TCP MD5 for BGP patch for Linux (RFC 2385)
			# original found at http://hasso.linux.ee/doku.php/english:network:rfc2385
			epatch "${WORKDIR}/patch/ht-20050321-${PV}-bgp-md5_adapted.patch"
		else
			# TCP MD5 in-kernel support for kernels >=2.6.20 (by Leigh Brown)
			# original found at http://www.solinno.co.uk/md5sig/quagga_linux-2.6.20_md5sig.diff
			epatch "${WORKDIR}/patch/quagga_linux-2.6.20_md5sig_adapted.diff"
		fi
	fi

	# Classless prefixes for BGP - http://hasso.linux.ee/doku.php/english:network:quagga
	use bgpclassless && epatch "${WORKDIR}/patch/ht-20040304-classless-bgp_adapted.patch"

	# Realms support (Calin Velea) - http://vcalinus.gemenii.ro/quaggarealms.html
	use realms && epatch "${WORKDIR}/patch/${P}-realms.diff"

	eautoreconf
}

src_compile() {
	local myconf="--disable-static \
		$(use_enable caps capabilities) \
		$(use_enable snmp) \
		$(use_with pam libpam) \
		$(use_enable tcpmd5 tcp-md5) \
		$(use_enable tcp-zebra)"
	use ipv6 \
			&& myconf="${myconf} --enable-ipv6 --enable-ripng --enable-ospf6d --enable-rtadv" \
			|| myconf="${myconf} --disable-ipv6 --disable-ripngd --disable-ospf6d"
	use ospfapi \
			&& myconf="${myconf} --enable-opaque-lsa --enable-ospf-te --enable-ospfclient"
	use realms && myconf="${myconf} --enable-realms"
	use multipath && myconf="${myconf} --enable-multipath=0"

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

	dodir /var/run/quagga || die "failed to install /var/run/quagga"

	local i MY_SERVICES_LIST="zebra ripd ospfd bgpd"
	use ipv6 && MY_SERVICES_LIST="${MY_SERVICES_LIST} ripngd ospf6d"
	for i in ${MY_SERVICES_LIST} ; do
		newinitd "${FILESDIR}/${i}.init" ${i} || die "failed to install ${i} init.d script"
	done
	newconfd "${FILESDIR}/zebra.conf" zebra || die "failed to install zebra conf.d script"

	if use pam; then
		insinto /etc/pam.d
		newins "${FILESDIR}/quagga.pam" quagga || die "failed to install pam.d file"
	fi

	newenvd "${FILESDIR}/quagga.env" 99quagga || die "failed to install env file"
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
		if kernel_is lt 2 6 20; then
			ewarn "TCP MD5 for BGP needs a patched kernel!"
			ewarn "See http://hasso.linux.ee/doku.php/english:network:rfc2385 for more info."
		else
			CONFIG_CHECK="~TCP_MD5SIG"
			local ERROR_TCP_MD5SIG="CONFIG_TCP_MD5SIG:\t missing TCP MD5 signature support (RFC2385)"

			check_extra_config
		fi
	fi
}

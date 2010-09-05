# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.99.17.ebuild,v 1.1 2010/09/05 17:09:36 flameeyes Exp $

EAPI="2"

CLASSLESS_BGP_PATCH=ht-20040304-classless-bgp.patch
REALMS_PATCH=quagga-0.99.14-realms-test2.diff

inherit eutils multilib autotools pam

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP."
HOMEPAGE="http://quagga.net/"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz
	bgpclassless? ( http://hasso.linux.ee/stuff/patches/quagga/${CLASSLESS_BGP_PATCH} )
	realms? ( http://linux.mantech.ro/download/quagga/${REALMS_PATCH} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="caps doc ipv6 snmp pam bgpclassless ospfapi realms multipath tcp-zebra elibc_glibc"

COMMON_DEPEND="sys-libs/readline
	caps? ( sys-libs/libcap )
	snmp? ( net-analyzer/net-snmp )
	pam? ( sys-libs/pam )
	!elibc_glibc? ( dev-libs/libpcre )"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/libtool-2.2.4"
RDEPEND="${COMMON_DEPEND}
	sys-apps/iproute2"

pkg_setup() {
	enewgroup quagga
	enewuser quagga -1 -1 /var/empty quagga
}

src_prepare() {
	# https://bugzilla.quagga.net/show_bug.cgi?id=486
	epatch "${FILESDIR}/${PN}-0.99.14-fix-ipremove.patch"

	epatch "${FILESDIR}/${P}-libcap.patch"

	# Classless prefixes for BGP - http://hasso.linux.ee/doku.php/english:network:quagga
	use bgpclassless && epatch "${DISTDIR}/${CLASSLESS_BGP_PATCH}"

	# Realms support (Calin Velea) - http://vcalinus.gemenii.ro/quaggarealms.html
	use realms && epatch "${DISTDIR}/${REALMS_PATCH}"

	eautoreconf
}

src_configure() {
	local myconf="--disable-static \
		$(use_enable caps capabilities) \
		$(use_enable snmp) \
		$(use_with pam libpam) \
		$(use_enable !elibc_glibc pcreposix) \
		$(use_enable tcp-zebra)
		$(use_enable doc)"
	use ipv6 \
			&& myconf="${myconf} --enable-ipv6 --enable-ripngd --enable-ospf6d --enable-rtadv" \
			|| myconf="${myconf} --disable-ipv6 --disable-ripngd --disable-ospf6d"
	use ospfapi \
			&& myconf="${myconf} --enable-opaque-lsa --enable-ospf-te --enable-ospfclient"
	use realms && myconf="${myconf} --enable-realms"
	use multipath && myconf="${myconf} --enable-multipath=0"

	econf \
		--enable-user=quagga \
		--enable-group=quagga \
		--enable-vty-group=quagga \
		--with-cflags="${CFLAGS}" \
		--enable-vtysh \
		--sysconfdir=/etc/quagga \
		--enable-exampledir=/usr/share/doc/${PF}/samples \
		--localstatedir=/var/run/quagga \
		--libdir=/usr/$(get_libdir)/quagga \
		${myconf} \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	keepdir /etc/quagga || die
	fowners root:quagga /etc/quagga || die
	fperms 0770 /etc/quagga || die

	newinitd "${FILESDIR}"/zebra.init.2 zebra || die

	# install ripd as a file, symlink the rest
	newinitd "${FILESDIR}"/quagga-services.init ripd || die

	for service in ospfd bgpd $(use ipv6 && echo ripngd ospf6d); do
		ln -s ripd "${D}"/etc/init.d/${service} || die
	done

	newpamd "${FILESDIR}/quagga.pam" quagga
}

pkg_postinst() {
	elog "Sample configuration files can be found in /usr/share/doc/${PF}/samples"
	elog "You have to create config files in /etc/quagga before"
	elog "starting one of the daemons."
	elog ""
	elog "You can pass additional options to the daemon by setting the EXTRA_OPTS"
	elog "variable in their respective file in /etc/conf.d"
}

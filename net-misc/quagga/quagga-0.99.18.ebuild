# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.99.18.ebuild,v 1.2 2011/03/22 17:06:23 flameeyes Exp $

EAPI="2"

CLASSLESS_BGP_PATCH=ht-20040304-classless-bgp.patch

BACKPORTS=1

inherit eutils multilib autotools pam

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP."
HOMEPAGE="http://quagga.net/"
SRC_URI="http://www.quagga.net/download/${P}.tar.gz
	${BACKPORTS:+
		http://dev.gentoo.org/~flameeyes/${PN}/${P}-backports-${BACKPORTS}.tar.bz2}
	bgpclassless? ( http://hasso.linux.ee/stuff/patches/quagga/${CLASSLESS_BGP_PATCH} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="caps doc ipv6 snmp pam bgpclassless ospfapi multipath tcp-zebra elibc_glibc +readline"

COMMON_DEPEND="
	caps? ( sys-libs/libcap )
	snmp? ( net-analyzer/net-snmp )
	readline? (
		sys-libs/readline
		pam? ( sys-libs/pam )
	)
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
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	# Classless prefixes for BGP
	# http://hasso.linux.ee/doku.php/english:network:quagga
	use bgpclassless && epatch "${DISTDIR}/${CLASSLESS_BGP_PATCH}"

	eautoreconf
}

src_configure() {
	local myconf=

	use ospfapi \
			&& myconf="${myconf} --enable-opaque-lsa --enable-ospf-te --enable-ospfclient"

	use multipath && myconf="${myconf} --enable-multipath=0"

	econf \
		--enable-user=quagga \
		--enable-group=quagga \
		--enable-vty-group=quagga \
		--with-cflags="${CFLAGS}" \
		--sysconfdir=/etc/quagga \
		--enable-exampledir=/usr/share/doc/${PF}/samples \
		--localstatedir=/var/run/quagga \
		--disable-static \
		--disable-pie \
		\
		$(use_enable caps capabilities) \
		$(use_enable snmp) \
		$(use_enable !elibc_glibc pcreposix) \
		$(use_enable tcp-zebra) \
		$(use_enable doc) \
		\
		$(use_enable readline vtysh) \
		$(use_with pam libpam) \
		\
		$(use_enable ipv6) \
		$(use_enable ipv6 ripngd) \
		$(use_enable ipv6 ospf6d) \
		$(use_enable ipv6 rtadv) \
		\
		${myconf} \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -delete || die

	keepdir /etc/quagga || die
	fowners root:quagga /etc/quagga || die
	fperms 0770 /etc/quagga || die

	newinitd "${FILESDIR}"/zebra.init.2 zebra || die

	# install ripd as a file, symlink the rest
	newinitd "${FILESDIR}"/quagga-services.init ripd || die

	for service in ospfd bgpd $(use ipv6 && echo ripngd ospf6d); do
		ln -s ripd "${D}"/etc/init.d/${service} || die
	done

	use readline && newpamd "${FILESDIR}/quagga.pam" quagga
}

pkg_postinst() {
	elog "Sample configuration files can be found in /usr/share/doc/${PF}/samples"
	elog "You have to create config files in /etc/quagga before"
	elog "starting one of the daemons."
	elog ""
	elog "You can pass additional options to the daemon by setting the EXTRA_OPTS"
	elog "variable in their respective file in /etc/conf.d"
	elog ""
	elog "Starting from version 0.99.18, quagga no longer supports the realms patch."
	elog "The patch was abandoned upstream and once again didn't apply; it needs a"
	elog "dedicated maintainer, if it is still necessary."
}

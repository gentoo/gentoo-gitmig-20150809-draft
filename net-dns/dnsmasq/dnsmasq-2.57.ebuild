# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-2.57.ebuild,v 1.3 2011/03/30 10:25:25 angelos Exp $

EAPI=2

inherit eutils toolchain-funcs flag-o-matic

MY_P="${P/_/}"
MY_PV="${PV/_/}"
DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${MY_P}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="dbus +dhcp idn ipv6 nls tftp"

RDEPEND="dbus? ( sys-apps/dbus )
	idn? ( net-dns/libidn )
	nls? (
		sys-devel/gettext
		net-dns/libidn
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| ( app-arch/xz-utils app-arch/lzma-utils )"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	# dnsmasq on FreeBSD wants the config file in a silly location, this fixes
	epatch "${FILESDIR}/${PN}-2.47-fbsd-config.patch"
}

src_configure() {
	COPTS=""
	use tftp || COPTS+=" -DNO_TFTP"
	use dhcp || COPTS+=" -DNO_DHCP"
	use ipv6 || COPTS+=" -DNO_IPV6"
	use dbus && COPTS+=" -DHAVE_DBUS"
	use idn  && COPTS+=" -DHAVE_IDN"
}

src_compile() {
	emake \
		PREFIX=/usr \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		COPTS="${COPTS}" \
		all$(use nls && echo "-i18n") || die
}

src_install() {
	emake \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		DESTDIR="${D}" \
		install$(use nls && echo "-i18n") || die

	dodoc CHANGELOG FAQ
	dohtml *.html

	newinitd "${FILESDIR}"/dnsmasq-init dnsmasq
	newconfd "${FILESDIR}"/dnsmasq.confd dnsmasq
	insinto /etc
	newins dnsmasq.conf.example dnsmasq.conf

	if use dbus ; then
		insinto /etc/dbus-1/system.d
		doins dbus/dnsmasq.conf
	fi
}

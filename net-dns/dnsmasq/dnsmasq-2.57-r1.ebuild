# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-2.57-r1.ebuild,v 1.3 2012/03/07 21:59:18 chutzpah Exp $

EAPI=4

inherit eutils toolchain-funcs flag-o-matic

MY_P="${P/_/}"
MY_PV="${PV/_/}"
DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${MY_P}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="dbus +dhcp idn ipv6 nls tftp"

RDEPEND="dbus? ( sys-apps/dbus )
	idn? ( net-dns/libidn )
	nls? (
		sys-devel/gettext
		net-dns/libidn
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| ( app-arch/xz-utils app-arch/lzma )"

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	enewgroup dnsmasq
	enewuser dnsmasq -1 -1 /dev/null dnsmasq
}

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
		all$(use nls && echo "-i18n")
}

src_install() {
	emake \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		DESTDIR="${D}" \
		install$(use nls && echo "-i18n")

	dodoc CHANGELOG FAQ
	dohtml *.html

	newinitd "${FILESDIR}"/dnsmasq-init dnsmasq
	newconfd "${FILESDIR}"/dnsmasq.confd-r1 dnsmasq
	insinto /etc
	newins dnsmasq.conf.example dnsmasq.conf

	if use dbus ; then
		insinto /etc/dbus-1/system.d
		doins dbus/dnsmasq.conf
	fi
}

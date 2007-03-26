# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-2.38-r1.ebuild,v 1.2 2007/03/26 07:51:13 antarus Exp $

inherit eutils toolchain-funcs flag-o-matic

MY_P="${P/_/}"
MY_PV="${PV/_rc*/}"
DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="dbus isc resolvconf tftp"

RDEPEND=""
DEPEND="${RDEPEND}
	dbus? ( sys-apps/dbus )
	resolvconf? ( net-dns/resolvconf-gentoo )"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	# dnsmasq on FreeBSD wants the config file in a silly location, this fixes
	epatch "${FILESDIR}/${PN}-fbsd-config.patch"
}

src_compile() {
	use tftp || append-flags -DNO_TFTP
	use dbus && sed -i '$ a #define HAVE_DBUS' src/config.h
	use isc && sed -i '$ a #define HAVE_ISC_READER' src/config.h
	emake CC="$(tc-getCC)" || die
}

src_install() {
	make \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		DESTDIR="${D}" \
		install || die
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

	if use resolvconf ; then
		exeinto /etc/resolvconf/update.d
		newexe ${FILESDIR}/resolvconf.dnsmasq dnsmasq
	fi
}

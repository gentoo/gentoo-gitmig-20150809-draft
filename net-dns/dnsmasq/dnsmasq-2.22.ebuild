# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-2.22.ebuild,v 1.7 2005/04/03 09:47:46 kloeri Exp $

inherit eutils toolchain-funcs

MY_P="${P/_/}"
MY_PV="${PV/_rc*/}"
DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ~mips ppc s390 sh sparc ~x86 ~alpha"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
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
}

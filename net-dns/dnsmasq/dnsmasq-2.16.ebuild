# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-2.16.ebuild,v 1.3 2004/11/22 00:02:39 solar Exp $

inherit eutils

MY_P="${P/_/}"
MY_PV="${PV/_rc*/}"
DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~arm ~amd64 ~ia64 ~s390"
IUSE=""

RDEPEND="virtual/libc"
DEPEND=">=sys-apps/sed-4 ${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	epatch ${FILESDIR}/dnsmasq-2.16-gcc34.diff
	emake || die
}

src_install() {
	make \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		DESTDIR=${D} \
		install || die
	dodoc CHANGELOG FAQ
	dohtml *.html

	exeinto /etc/init.d
	newexe ${FILESDIR}/dnsmasq-init dnsmasq
	insinto /etc/conf.d
	newins ${FILESDIR}/dnsmasq.confd dnsmasq
	insinto /etc
	newins dnsmasq.conf.example dnsmasq.conf
}

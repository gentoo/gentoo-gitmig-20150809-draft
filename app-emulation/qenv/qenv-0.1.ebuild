# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qenv/qenv-0.1.ebuild,v 1.2 2007/01/04 13:59:48 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools eutils

DESCRIPTION="Pool of machines handler for QEMU"
HOMEPAGE="http://virutass.net/software/qemu/"
SRC_URI="http://virutass.net/software/qemu/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# these should in RDEPEND only, but configure fails without them
RDEPEND=">=app-emulation/qemu-0.7.2
		net-firewall/iptables
		net-misc/bridge-utils
		app-admin/sudo
		net-dns/dnsmasq"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch	${FILESDIR}/${PN}-0.1-qemu-0.7.2.patch

	cd "${S}"
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc README AUTHORS
}

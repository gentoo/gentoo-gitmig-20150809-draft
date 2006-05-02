# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/nss-mdns/nss-mdns-0.8.ebuild,v 1.1 2006/05/02 01:11:13 compnerd Exp $

inherit eutils

DESCRIPTION="Name Service Switch module for Multicast DNS"
HOMEPAGE="http://0pointer.de/lennart/projects/nss-mdns/"
SRC_URI="http://0pointer.de/lennart/projects/nss-mdns/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="avahi"

DEPEND="avahi? ( net-dns/avahi )"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_enable avahi) || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	insinto /etc
	doins ${FILESDIR}/mdns.allow

	dodoc README
}

pkg_postinst() {
	ewarn
	ewarn "You must modify your name service switch look up file to enable"
	ewarn "multicast DNS lookups.  If you wish to resolve only IPv6 addresses"
	ewarn "use mdns6.  For IPv4 addresses only, use mdns4.  To resolve both"
	ewarn "use mdns2.  Keep in mind that mdns2 will be slower if there are no"
	ewarn "IPv6 addresses on the network.  There are minimal (mdns?_minimal)"
	ewarn "for slightly faster resolution which do not wait for timeouts."
	ewarn
	ewarn "Add the appropriate mdns into the hosts line in /etc/nsswitch.conf"
	ewarn "An example line looks like:"
	einfo "hosts:	files mdns4 dns"
	ewarn
	ewarn "Add any domains other than those ending in .local to"
	ewarn "/etc/mdns.allow"
	ewarn
	ebeep 5
	epause 10
}

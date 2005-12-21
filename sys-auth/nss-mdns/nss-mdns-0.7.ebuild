# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/nss-mdns/nss-mdns-0.7.ebuild,v 1.1 2005/12/21 07:20:16 compnerd Exp $

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
	dodoc README
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcdbd/dhcdbd-1.12-r3.ebuild,v 1.1 2006/10/28 22:06:35 metalgod Exp $

inherit eutils

DESCRIPTION="DHCP D-BUS daemon (dhcdbd) controls dhclient sessions with D-BUS, stores and presents DHCP options."
HOMEPAGE="http://people.redhat.com/~jvdias/dhcdbd"
SRC_URI="http://people.redhat.com/~jvdias/dhcdbd/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-apps/dbus
	>=net-misc/dhcp-3.0.3-r7"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README dhcp_options.h
	newinitd ${FILESDIR}/dhcdbd.init dhcdbd
	newconfd ${FILESDIR}/dhcdbd.confd dhcdbd

}

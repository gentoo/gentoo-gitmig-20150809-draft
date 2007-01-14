# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcdbd/dhcdbd-1.14-r1.ebuild,v 1.3 2007/01/14 11:08:45 corsair Exp $

inherit eutils

DESCRIPTION="DHCP D-BUS daemon (dhcdbd) controls dhclient sessions with D-BUS, stores and presents DHCP options."
HOMEPAGE="http://people.redhat.com/~jvdias/dhcdbd"
SRC_URI="http://people.redhat.com/~jvdias/dhcdbd/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="sys-apps/dbus
	>=net-misc/dhcp-3.0.3-r7"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.14-fix_dhclientconf.patch
	epatch ${FILESDIR}/${PN}-1.14-dbus_close.patch
	# This doesn't truely enable debugging, it simply allows us to see
	# more info about state changes, hopefully.
	use debug && epatch "${FILESDIR}/${PN}-1.14-enable_debug.patch"
}
src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README dhcp_options.h
	newinitd ${FILESDIR}/dhcdbd.init dhcdbd
	newconfd ${FILESDIR}/dhcdbd.confd dhcdbd
}

pkg_postinst() {
	einfo "dhcddb is used by NetworkManager in order to use it"
	einfo "you can add it to runlevels by writing on your terminal"
	einfo "rc-update add dhcdbd default"
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcdbd/dhcdbd-2.8-r1.ebuild,v 1.3 2007/08/24 06:54:06 opfer Exp $

inherit eutils

DESCRIPTION="DHCP D-BUS daemon (dhcdbd) controls dhclient sessions with D-BUS, stores and presents DHCP options."
HOMEPAGE="http://people.redhat.com/dcantrel/dhcdbd"
SRC_URI="http://people.redhat.com/dcantrel/dhcdbd/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

DEPEND="sys-apps/dbus
	>=net-misc/dhcp-3.0.3-r7"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.5-fixes.patch
	# Commented out for the moment as I need to re-work this to make it cleaner.
	#use debug && epatch ${FILESDIR}/${PN}-2.5-debug.patch

	# Create a pidfile immediately after daemonizing so we're more robust
	# with baselayout-2
	epatch ${FILESDIR}/${P}-daemon.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README include/dhcp_options.h
	newinitd ${FILESDIR}/dhcdbd.init dhcdbd
	newconfd ${FILESDIR}/dhcdbd.confd dhcdbd
}

pkg_postinst() {
	einfo "dhcdbd is used by NetworkManager."
	einfo "If you really feel you need to use it without that, simply add it"
	einfo "to your runlevel by issuing the following command:"
	einfo "rc-update add dhcdbd default"
}

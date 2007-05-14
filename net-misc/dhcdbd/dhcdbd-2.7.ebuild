# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcdbd/dhcdbd-2.7.ebuild,v 1.1 2007/05/14 16:53:56 steev Exp $

inherit eutils

DESCRIPTION="DHCP D-BUS daemon (dhcdbd) controls dhclient sessions with D-BUS, stores and presents DHCP options."
HOMEPAGE="http://people.redhat.com/dcantrel/dhcdbd"
SRC_URI="http://people.redhat.com/dcantrel/dhcdbd/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="sys-apps/dbus
	>=net-misc/dhcp-3.0.3-r7"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.5-fixes.patch
	# Commented out for the moment as I need to re-work this to make it cleaner.
	#use debug && epatch ${FILESDIR}/${PN}-2.5-debug.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README include/dhcp_options.h
	newinitd ${FILESDIR}/dhcdbd.init dhcdbd
	newconfd ${FILESDIR}/dhcdbd.confd dhcdbd
}

pkg_postinst() {
	einfo "dhcdbd is used by NetworkManager in order to use it"
	einfo "you can add it to runlevels by writing on your terminal"
	einfo "rc-update add dhcdbd default"
}

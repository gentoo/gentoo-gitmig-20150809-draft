# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdnssd-avahi/kdnssd-avahi-0.1.2-r1.ebuild,v 1.3 2009/06/06 16:22:26 nixnut Exp $

inherit kde

DESCRIPTION="DNS Service Discovery kioslave using Avahi (rather than mDNSResponder)"
HOMEPAGE="http://wiki.kde.org/tiki-index.php?page=Zeroconf+in+KDE"
SRC_URI="http://helios.et.put.poznan.pl/~jstachow/pub/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ppc ~ppc64 ~sparc x86 ~x86-fbsd"

RDEPEND="net-dns/avahi"
DEPEND="${RDEPEND}"

need-kde 3.5

# Install into the KDE prefix, only used by KDE. See bug 237830.
PREFIX="/usr/kde/3.5"

pkg_setup() {
	if ! built_with_use net-dns/avahi qt3 dbus; then
		eerror "To compile kdnssd-avahi package you need Avahi with DBus and Qt 3.x support."
		eerror "but net-dns/avahi is not built with qt3 and/or dbus USE flags enabled."
		die "Please, rebuild net-dns/avahi with the \"qt3\" and \"dbus\" USE flags."
	fi
}

src_compile() {
	kde_src_compile myconf configure

	emake -C "${S}/${PN}" mocs || die "make mocs failed"

	kde_src_compile make
}

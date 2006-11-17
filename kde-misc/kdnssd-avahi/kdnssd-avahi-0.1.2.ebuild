# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdnssd-avahi/kdnssd-avahi-0.1.2.ebuild,v 1.1 2006/11/17 18:32:14 flameeyes Exp $

inherit kde

DESCRIPTION="DNS Service Discovery kioslave using Avahi (rather than mDNSResponder)"
HOMEPAGE="http://wiki.kde.org/tiki-index.php?page=Zeroconf+in+KDE"
SRC_URI="http://helios.et.put.poznan.pl/~jstachow/pub/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="net-dns/avahi"
DEPEND="${RDEPEND}"

need-kde 3.5

src_compile() {
	kde_src_compile myconf configure

	emake -C "${S}/${PN}" mocs || die "make mocs failed"

	kde_src_compile make
}

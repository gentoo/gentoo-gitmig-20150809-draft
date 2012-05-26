# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/dhcpcd-dbus/dhcpcd-dbus-0.6.0.ebuild,v 1.2 2012/05/26 23:49:12 idl0r Exp $

EAPI=4

DESCRIPTION="DBus bindings for dhcpcd"
HOMEPAGE="http://roy.marples.name/projects/dhcpcd-dbus/"
SRC_URI="http://roy.marples.name/downloads/dhcpcd/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/dbus"
RDEPEND="${DEPEND}
	>=net-misc/dhcpcd-5.0"

src_configure() {
	econf --localstatedir=/var
}


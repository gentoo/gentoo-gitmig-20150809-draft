# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd-ui/dhcpcd-ui-0.5.1.ebuild,v 1.1 2010/12/12 02:27:39 darkside Exp $

EAPI=3

DESCRIPTION="Desktop notification and configuration for dhcpcd"
HOMEPAGE="http://roy.marples.name/projects/dhcpcd-ui/"
SRC_URI="http://roy.marples.name/downloads/dhcpcd/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/dhcpcd-dbus
	>=x11-libs/libnotify-0.4.4
	x11-libs/gtk+:2"

src_install() {
	emake DESTDIR="${D}" install || die
}

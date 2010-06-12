# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd-ui/dhcpcd-ui-0.5.0.ebuild,v 1.1 2010/06/12 21:35:25 darkside Exp $

EAPI=3

DESCRIPTION="Desktop notification and configuration for dhcpcd"
HOMEPAGE="http://roy.marples.name/projects/dhcpcd-ui/"
SRC_URI="http://roy.marples.name/downloads/dhcpcd/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk"

DEPEND="net-libs/dhcpcd-dbus
	gtk? ( >x11-libs/gtk+-2 )"

src_configure() {
	econf $(use_with gtk)
}

src_install() {
	emake DESTDIR="${D}" install || die
}

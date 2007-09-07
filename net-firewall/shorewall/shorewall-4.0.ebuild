# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-4.0.ebuild,v 1.2 2007/09/07 20:25:06 jer Exp $

inherit eutils

DESCRIPTION="Shoreline Firewall is an iptables-based firewall for Linux."
HOMEPAGE="http://www.shorewall.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND=">=net-firewall/shorewall-common-${PV}"

pkg_setup() {
	ewarn "Shorewall as such has been removed and split into three packages:"
	ewarn "shorewall-common, shorewall-shell and shorewall-perl."
	ewarn "From now on you should emerge shorewall-shell and/or shorewall-perl."
	ewarn ""
	ewarn "As of ${PV} shorewall-shell and shorewall-common are required at"
	ewarn "compile time even if you only wish to use shorewall-perl."
	ewarn "This will probably change in the future."
}

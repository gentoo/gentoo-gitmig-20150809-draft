# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-4.0-r1.ebuild,v 1.1 2008/02/25 18:03:25 pva Exp $

inherit eutils

DESCRIPTION="Shoreline Firewall is an iptables-based firewall for Linux."
HOMEPAGE="http://www.shorewall.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=net-firewall/shorewall-common-${PV}"

pkg_setup() {
	ewarn "Shorewall as such has been removed and split into three packages:"
	ewarn "shorewall-common, shorewall-shell and shorewall-perl."
	ewarn "From now on you should emerge shorewall-shell and/or shorewall-perl."
	ewarn ""
	ewarn "If you are upgrading from <${P} and you wish to continue using the"
	ewarn "shell compiler then you should emerge shorewall-shell. If you decide"
	ewarn "to move to the perl compiler then you can also emerge shorewall-perl"
	ewarn "and specify the compiler type in shorewall.conf."
	ewarn "If this is a new installation then you can emerge shorewall-shell"
	ewarn "and/or shorewall-perl."
}

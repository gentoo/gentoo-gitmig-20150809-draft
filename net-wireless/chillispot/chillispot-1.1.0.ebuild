# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/chillispot/chillispot-1.1.0.ebuild,v 1.3 2008/01/13 08:54:29 vapier Exp $

DESCRIPTION="open source captive portal or wireless LAN access point controller"
HOMEPAGE="http://www.chillispot.org/"
SRC_URI="http://www.chillispot.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~mips ~ppc s390 sh ~sparc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	chmod 644 doc/*.conf
	find . -exec chmod go-w '{}' \;
}

src_install() {
	einstall STRIPPROG=true || die "einstall failed"
	cd doc && dodoc chilli.conf freeradius.users hotspotlogin.cgi firewall.iptables

	# init script provided by Michele Beltrame bug #124698
	newinitd "${FILESDIR}"/${PN} ${PN} || die
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_roaming/mod_roaming-2.0.0-r1.ebuild,v 1.3 2005/02/25 12:32:26 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Apache2 DSO enabling Netscape Communicator roaming profiles"
HOMEPAGE="http://www.klomp.org/mod_roaming/"
SRC_URI="http://www.klomp.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

APACHE2_MOD_CONF="${PVR}/18_mod_roaming"
APACHE2_MOD_DEFINE="ROAMING"

DOCFILES="CHANGES INSTALL LICENSE README"

need_apache2

pkg_postinst() {
	install -d -m 0755 -o apache -g apache ${ROOT}/var/lib/mod_roaming
}

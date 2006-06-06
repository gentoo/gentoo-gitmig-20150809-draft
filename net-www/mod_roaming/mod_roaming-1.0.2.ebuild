# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_roaming/mod_roaming-1.0.2.ebuild,v 1.4 2006/06/06 09:37:33 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Apache2 DSO enabling Netscape Communicator roaming profiles"
HOMEPAGE="http://www.klomp.org/mod_roaming/"
SRC_URI="http://www.klomp.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86"
IUSE=""
SLOT="0"

APACHE1_MOD_CONF="18_mod_roaming"
APACHE1_MOD_DEFINE="ROAMING"

DOCFILES="CHANGES INSTALL LICENSE README"

need_apache1

pkg_postinst() {
	install -d -m 0755 -o apache -g apache ${ROOT}/var/lib/mod_roaming
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_roaming/mod_roaming-1.0.2.ebuild,v 1.5 2007/01/14 19:04:42 chtekk Exp $

inherit apache-module

KEYWORDS="x86"

DESCRIPTION="Apache1 module enabling Netscape Communicator roaming profiles."
HOMEPAGE="http://www.klomp.org/mod_roaming/"
SRC_URI="http://www.klomp.org/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""

APACHE1_MOD_CONF="18_mod_roaming"
APACHE1_MOD_DEFINE="ROAMING"

DOCFILES="CHANGES INSTALL LICENSE README"

need_apache1

pkg_postinst() {
	install -d -m 0755 -o apache -g apache "${ROOT}"/var/lib/${PN}
	apache1_pkg_postinst
}

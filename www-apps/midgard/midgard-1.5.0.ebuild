# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/midgard/midgard-1.5.0.ebuild,v 1.1 2004/09/22 11:20:57 rl03 Exp $

DESCRIPTION="The Midgard framework metapackage"
HOMEPAGE="http://www.midgard-project.org/"

LICENSE="GPL-2 | LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=www-apps/midgard-lib-${PV}
	=www-apache/mod_midgard-preparse-${PV}
	=www-apps/midgard-php4-${PV}
	=www-apps/midgard-data-${PV}
	www-apps/asgard
	www-apps/aegir
	www-apps/midcom
	www-apps/spider-admin
"
pkg_postrm() {
	einfo "Note: this is a META ebuild for ${P}."
	einfo "to remove it completely or before re-emerging"
	einfo "either use 'depclean', or remove/re-emerge these packages:"
	echo ""
	for dep in ${RDEPEND}; do
		einfo "     ${dep}"
	done
	echo ""
}

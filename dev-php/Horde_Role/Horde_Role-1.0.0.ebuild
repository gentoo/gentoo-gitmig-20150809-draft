# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Role/Horde_Role-1.0.0.ebuild,v 1.2 2011/06/15 16:59:52 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="PEAR installer role used to install Horde components"
LICENSE="LGPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/get/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "Setting horde_dir PEAR setting..."
	pear config-set horde_dir /usr/share/horde system || die 'pear config-set failed'
}

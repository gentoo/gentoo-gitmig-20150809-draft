# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/creole/creole-1.0.1_beta.ebuild,v 1.3 2006/10/20 17:27:29 sebastian Exp $

inherit php-lib-r1

KEYWORDS="~x86"
DESCRIPTION="Database abstraction layer for PHP 4."
HOMEPAGE="http://creole.phpdb.org/trac/wiki"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

MY_P="${PN}-php4-${PV/_/}"
SRC_URI="http://creole.tigris.org/files/documents/996/21587/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

RDEPEND="${RDEPEND} >=dev-php4/jargon-1.0.1_beta"

need_php_by_category

src_install() {
	# install files
	php-lib-r1_src_install ./classes/creole `find ./classes/creole -type f -print | sed -e "s|./classes/creole||g"`
}

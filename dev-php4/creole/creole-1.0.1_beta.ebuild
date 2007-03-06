# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/creole/creole-1.0.1_beta.ebuild,v 1.5 2007/03/06 14:44:46 chtekk Exp $

inherit php-lib-r1

KEYWORDS="~amd64 ~x86"

MY_P="${PN}-php4-${PV/_/}"

DESCRIPTION="Database abstraction layer for PHP 4."
HOMEPAGE="http://creole.phpdb.org/trac/wiki/"
SRC_URI="http://creole.tigris.org/files/documents/996/21587/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=dev-php4/jargon-1.0.1_beta"

S="${WORKDIR}/${MY_P}"

need_php_by_category

src_install() {
	php-lib-r1_src_install ./classes/creole `find ./classes/creole -type f -print | sed -e "s|./classes/creole||g"`
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/jargon/jargon-1.0.2.ebuild,v 1.1 2005/09/18 14:28:31 hollow Exp $

inherit php-lib-r1

DESCRIPTION="Convenience tools built on top of Creole."
HOMEPAGE="http://creole.phpdb.org/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

MY_P="creole-${PV}"
SRC_URI="http://creole.tigris.org/files/documents/996/22124/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

RDEPEND="${RDEPEND} >=dev-php5/creole-1.0.2"

need_php_by_category

src_install() {
	# install files
	php-lib-r1_src_install ./classes/jargon `find ./classes/jargon -type f -print | sed -e "s|./classes/jargon||g"`
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/cphplib/cphplib-0.48.ebuild,v 1.2 2005/11/24 12:05:00 chtekk Exp $

inherit php-lib-r1

DESCRIPTION="Cute PHP Library (cphplib)"
HOMEPAGE="http://www.meindlsoft.com/cphplib.php"
SRC_URI="mirror://sourceforge/cphplib/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND} >=dev-php/PEAR-DB-1.7.6-r1"
RDEPEND="${RDEPEND} >=dev-php/PEAR-DB-1.7.6-r1"

need_php_by_category

src_install() {
	# install php files
	php-lib-r1_src_install . *.spec
	php-lib-r1_src_install . *.inc

	# install documentation
	dodoc-php ChangeLog COPYRIGHT LGPL README TODO
}

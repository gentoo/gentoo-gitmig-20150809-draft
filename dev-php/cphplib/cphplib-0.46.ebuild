# Copyright 1999-2004 Gentoo Foundation.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/cphplib/cphplib-0.46.ebuild,v 1.1 2004/07/31 18:07:45 coredumb Exp $

inherit php-lib

DESCRIPTION="Cute PHP Library (cphplib)"
HOMEPAGE="http://www.meindlsoft.com/cphplib.php"
SRC_URI="mirror://sourceforge/cphplib/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/php dev-php/PEAR-DB"
RDEPEND="${DEPEND}"

src_install() {

	# install php files
	php-lib_src_install . *.php
	php-lib_src_install . *.inc

	# install documentation
	dodoc ChangeLog COPYRIGHT LGPL README TODO
}

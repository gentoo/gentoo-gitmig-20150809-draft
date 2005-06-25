# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpconfig/phpconfig-5.0.4.ebuild,v 1.2 2005/06/25 14:37:02 swegener Exp $

DESCRIPTION="PECL build environment for PHP"
HOMEPAGE="http://www.php.net/"
SRC_URI="http://dev.gentoo.org/~stuart/php/${P}.tar.bz2"
LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="|| ( =virtual/php-5* =virtual/httpd-php-5* )"
#RDEPEND=""

src_install() {
	cp -r * ${D}
}

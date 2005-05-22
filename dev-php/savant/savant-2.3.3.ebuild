# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/savant/savant-2.3.3.ebuild,v 1.1 2005/05/22 10:40:20 stuart Exp $

PHP_PEAR_PKG_NAME="Savant2"
DESCRIPTION="The simple PHP template alternative to Smarty"
HOMEPAGE="http://phpsavant.com/"
SRC_URI="http://phpsavant.com/${PHP_PEAR_PKG_NAME}-${PV}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/php"
IUSE=""

inherit php-pear

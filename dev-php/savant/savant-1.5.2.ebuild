# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/savant/savant-1.5.2.ebuild,v 1.2 2004/09/05 05:51:23 swegener Exp $

PHP_PEAR_PKG_NAME="Savant"
DESCRIPTION="The simple PHP template alternative to Smarty"
HOMEPAGE="http://phpsavant.com/"
SRC_URI="http://phpsavant.com/${PHP_PEAR_PKG_NAME}-${PV}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/php"
IUSE=""

inherit php-pear

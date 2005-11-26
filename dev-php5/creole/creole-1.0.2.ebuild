# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/creole/creole-1.0.2.ebuild,v 1.2 2005/11/26 22:20:44 chtekk Exp $

inherit php-pear-lib-r1

KEYWORDS="~x86"
DESCRIPTION="Database abstraction layer for PHP 5."
HOMEPAGE="http://creole.phpdb.org/wiki/"
SRC_URI="http://creole.phpdb.org/pear/${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND} >=dev-php5/jargon-1.0.2"

need_php_by_category

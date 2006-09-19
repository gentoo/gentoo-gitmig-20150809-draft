# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/creole/creole-1.1.0_rc1.ebuild,v 1.1 2006/09/19 17:33:41 sebastian Exp $

inherit php-pear-lib-r1

KEYWORDS="~x86 ~amd64"
DESCRIPTION="Database abstraction layer for PHP 5."
HOMEPAGE="http://creole.phpdb.org/wiki/"
#SRC_URI="http://creole.phpdb.org/pear/${P}.tgz"
SRC_URI="http://pear.phpdb.org/get/creole-1.1.0RC1.tgz"
S="${WORKDIR}/creole-1.1.0RC1"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND} >=dev-php5/jargon-1.1.0_rc1"

need_php_by_category

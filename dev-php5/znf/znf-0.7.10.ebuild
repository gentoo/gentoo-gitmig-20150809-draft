# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/znf/znf-0.7.10.ebuild,v 1.1 2007/11/29 23:54:21 jokey Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~sparc ~x86"

MY_P="ZNF-${PV}"

DESCRIPTION="PHP5 MVC framework for enterprise web applications."
HOMEPAGE="http://znf.zeronotice.com/"
SRC_URI="http://pear.zeronotice.org/get/${MY_P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="minimal"

DEPEND=">=dev-php/PEAR-PEAR-1.6.2"
RDEPEND="!minimal? ( >=dev-php/PEAR-DB-1.7.6-r1
			>=dev-php/smarty-2.6.10-r1 )"

S="${WORKDIR}/${MY_P}"

need_php_by_category

pkg_setup() {
	require_php_with_use xml xsl
}

pkg_postinst() {
	has_php
	if ! built_with_use =${PHP_PKG} pdo ; then
		elog "${PN} can optionally use PDO features. If you want those,"
		elog "re-emerge ${PHP_PKG} with USE=\"pdo\"."
	fi
}

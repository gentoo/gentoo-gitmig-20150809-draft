# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/propel-generator/propel-generator-1.2.0.ebuild,v 1.1 2006/09/20 11:00:19 sebastian Exp $

inherit php-pear-lib-r1

DESCRIPTION="Object Persistence Layer for PHP 5 (Generator)"
HOMEPAGE="http://propel.phpdb.org/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="http://pear.phpdb.org/get/propel_generator-${PV}.tgz"
RDEPEND=">=dev-php5/phing-2.2.0"
S="${WORKDIR}/propel_generator-${PV}"

need_php_by_category

pkg_setup() {
	require_php_with_use simplexml
}

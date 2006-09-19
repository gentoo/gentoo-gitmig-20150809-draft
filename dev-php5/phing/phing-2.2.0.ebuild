# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phing/phing-2.2.0.ebuild,v 1.1 2006/09/19 17:33:02 sebastian Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="PHP project build system based on Apache Ant."
HOMEPAGE="http://www.phing.info/"
SRC_URI="pear.phing.info/get/phing-${PV}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

need_php_by_category

pkg_setup() {
	has_php

	# Phing requires some features from PHP to work correctly
	if has_version '>=dev-lang/php-5.1.2' ; then
		require_php_with_use cli spl reflection xml xsl
	else
		require_php_with_use cli spl xml xsl
	fi
}

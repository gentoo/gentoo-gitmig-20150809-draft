# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR_PackageFileManager/PEAR-PEAR_PackageFileManager-1.6.3.ebuild,v 1.3 2008/03/17 12:49:06 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Takes an existing package.xml file and updates it with a new filelist and changelog."

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-PHP_CompatInfo-1.4.0 )"

pkg_setup() {
	require_php_with_use xml simplexml
}

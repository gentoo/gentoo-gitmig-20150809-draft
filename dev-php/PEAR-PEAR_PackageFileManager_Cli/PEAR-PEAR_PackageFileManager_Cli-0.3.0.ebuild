# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR_PackageFileManager_Cli/PEAR-PEAR_PackageFileManager_Cli-0.3.0.ebuild,v 1.3 2008/03/03 16:57:44 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="A command line interface to PEAR_PackageFileManager."

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-PEAR_PackageFileManager-1.6.0"

pkg_setup() {
	require_php_with_use xml simplexml
}

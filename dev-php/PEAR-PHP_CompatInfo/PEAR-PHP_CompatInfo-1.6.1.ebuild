# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_CompatInfo/PEAR-PHP_CompatInfo-1.6.1.ebuild,v 1.2 2011/03/26 11:37:06 olemarkus Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Find out the minimum version and the extensions required for a piece of code to run."

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-Console_Table-1.0.5
		    >=dev-php/PEAR-Console_Getargs-1.3.3
		    >=dev-php/PEAR-XML_Util-1.1.4
		    >=dev-php/phpunit-3.2.0 )"

pkg_setup() {
	require_php_with_use tokenizer
}

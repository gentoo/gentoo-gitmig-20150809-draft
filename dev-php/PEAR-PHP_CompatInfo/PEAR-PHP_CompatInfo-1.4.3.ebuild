# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_CompatInfo/PEAR-PHP_CompatInfo-1.4.3.ebuild,v 1.2 2007/08/30 18:37:51 mr_bones_ Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Find out the minimum version and the extensions required for a piece of code to run."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-Console_Table-1.0.5
		    >=dev-php/PEAR-Console_Getargs-1.3.3 )"

pkg_setup() {
	require_php_with_use tokenizer
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_CompatInfo/PEAR-PHP_CompatInfo-1.5.0.ebuild,v 1.1 2007/11/15 18:58:30 jokey Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Find out the minimum version and the extensions required for a piece of code to run."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-Console_Table-1.0.5
		    >=dev-php/PEAR-Console_Getargs-1.3.3 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	edos2unix $(find . -type f -print)
}

pkg_setup() {
	require_php_with_use tokenizer
}

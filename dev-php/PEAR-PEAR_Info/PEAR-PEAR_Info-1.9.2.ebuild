# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR_Info/PEAR-PEAR_Info-1.9.2.ebuild,v 1.2 2010/05/29 17:49:57 armin76 Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Show Information about your PEAR install and its packages"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE="minimal"

DEPEND="dev-php/PEAR-Console_Getargs"
RDEPEND="!minimal? ( >=dev-php5/phpunit-3.1.4 )"

pkg_setup() {
	has_php

	require_php_with_use pcre
}

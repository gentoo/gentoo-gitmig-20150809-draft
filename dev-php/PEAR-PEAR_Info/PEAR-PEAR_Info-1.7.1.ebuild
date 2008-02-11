# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR_Info/PEAR-PEAR_Info-1.7.1.ebuild,v 1.1 2008/02/11 20:58:48 armin76 Exp $

inherit php-pear-r1

DESCRIPTION="Show Information about your PEAR install and its packages"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php5/phpunit-3.1.4 )"

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/simpletest/simpletest-1.0.0-r1.ebuild,v 1.1 2005/11/24 12:02:04 chtekk Exp $

inherit php-pear-lib-r1

DESCRIPTION="A PHP testing framework."
HOMEPAGE="http://www.lastcraft.com/simple_test.php"
LICENSE="OGTSL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="mirror://sourceforge/simpletest/${PN}_${PV}.tgz"

need_php_by_category

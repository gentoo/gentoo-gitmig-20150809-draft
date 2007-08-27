# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Common2/PEAR-HTML_Common2-2.0.0_beta1.ebuild,v 1.1 2007/08/27 10:54:53 jokey Exp $

SRC_URI="http://pear.php.net/get/${PN/PEAR-/}-${PV/_/}.tgz"
inherit php-pear-r1

DESCRIPTION="Abstract base class for HTML classes (PHP5 port of PEAR-HTML_Common package)."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/php-5.1.4"

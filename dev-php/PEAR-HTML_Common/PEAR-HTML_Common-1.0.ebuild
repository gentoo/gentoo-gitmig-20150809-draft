# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Common/PEAR-HTML_Common-1.0.ebuild,v 1.4 2003/09/08 04:56:27 msterret Exp $

P=${PN/PEAR-//}-${PV}
DESCRIPTION="base class for other HTML classes"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=69"
SRC_URI="http://pear.php.net/get/${P}.tgz"

LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/php"

src_install() {
	insinto /usr/lib/php/HTML
	doins Common.php
}

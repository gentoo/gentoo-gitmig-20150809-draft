# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Common/PEAR-HTML_Common-1.0.ebuild,v 1.1 2003/02/18 13:49:56 tad Exp $

IUSE=""
P=${PN/PEAR-//}-${PV}
DESCRIPTION="PEAR::HTML_Common is a base class for other HTML classes."
HOMEPAGE="http://pear.php.net/package-info.php?pacid=69"
SRC_URI="http://pear.php.net/get/${P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_install () {
	insinto /usr/lib/php/HTML
	doins Common.php
}

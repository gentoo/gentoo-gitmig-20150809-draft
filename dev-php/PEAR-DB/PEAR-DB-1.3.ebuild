# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB/PEAR-DB-1.3.ebuild,v 1.4 2004/03/15 19:17:45 coredumb Exp $

MY_P=${PN/PEAR-//}-${PV}
DESCRIPTION="Database abstraction layer for PHP"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=46"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/lib/php/
	doins DB.php
	insinto /usr/lib/php/DB/
	doins DB/*
}

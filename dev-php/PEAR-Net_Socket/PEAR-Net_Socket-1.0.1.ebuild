# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_Socket/PEAR-Net_Socket-1.0.1.ebuild,v 1.1 2002/11/18 14:31:18 mcummings Exp $

P=${PN/PEAR-//}-${PV}
DESCRIPTION="Net_Socket is a class interface to TCP sockets."
HOMEPAGE="http://pear.php.net/package-info.php?pacid=64"
SRC_URI="http://pear.php.net/get/${P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ppc sparc"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_install () {
	insinto /usr/lib/php/
	doins Socket.php
}


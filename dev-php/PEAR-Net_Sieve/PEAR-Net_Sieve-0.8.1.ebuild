# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_Sieve/PEAR-Net_Sieve-0.8.1.ebuild,v 1.4 2004/02/01 10:32:11 coredumb Exp $

MY_P=${PN/PEAR-//}-${PV}
DESCRIPTION="Provides an API to talk to the timsieved server that comes with Cyrus IMAPd. Can be used to install, remove, mark active etc sieve scripts."
HOMEPAGE="http://pear.php.net/package-info.php?pacid=71"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/lib/php/Net
	doins Sieve.php
}


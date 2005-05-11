# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/karchiver/karchiver-3.1.1-r1.ebuild,v 1.2 2005/05/11 20:58:01 carlo Exp $

inherit kde

DESCRIPTION="Utility to ease working with compressed files such as tar.gz/tar.bz2"
HOMEPAGE="http://perso.wanadoo.fr/coquelle/karchiver/"
SRC_URI="http://perso.wanadoo.fr/coquelle/karchiver/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"
SLOT="0"
IUSE=""

need-kde 3.1

# Nasty packaging...
src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf karchiver/.libs
	rm -f karchiver/*.l[ao] karchiver/*.o
	rm -f config.log config.status
}

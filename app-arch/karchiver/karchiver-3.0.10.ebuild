# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/karchiver/karchiver-3.0.10.ebuild,v 1.3 2004/11/25 12:52:37 carlo Exp $

inherit kde eutils
need-kde 3.1

DESCRIPTION="Utility to ease working with compressed files such as tar.gz/tar.bz2"
HOMEPAGE="http://perso.wanadoo.fr/coquelle/karchiver/"
SRC_URI="http://perso.wanadoo.fr/coquelle/karchiver/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

SLOT="0"
IUSE=""

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}-gcc3.4.patch
}
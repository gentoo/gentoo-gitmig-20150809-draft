# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mcdp/mcdp-0.3j.ebuild,v 1.2 2003/09/07 00:06:06 msterret Exp $

DESCRIPTION="A very small console cd player"
HOMEPAGE="http://www.mcmilk.de/projects/mcdp/"
SRC_URI="http://www.mcmilk.de/projects/mcdp/dl/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="dev-libs/dietlibc"

src_unpack()
{
	unpack ${P}.tar.gz
}

src_compile()
{
	cd ${P}
	make || die
}

src_install()
{
	DESTDIR=${D}
	dobin mcdp || die
	doman mcdp.1 || die
}



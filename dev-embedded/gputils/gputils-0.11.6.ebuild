# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gputils/gputils-0.11.6.ebuild,v 1.5 2004/03/23 18:33:03 dragonheart Exp $

DESCRIPTION="Utils for the PICxxx procesors"
SRC_URI="mirror://sourceforge/gputils/${P}.tar.gz"
HOMEPAGE="http://gputils.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""
DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc doc/gputils.ps
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gputils/gputils-0.11.6.ebuild,v 1.7 2004/06/29 13:24:15 vapier Exp $

DESCRIPTION="Utils for the PICxxx procesors"
HOMEPAGE="http://gputils.sourceforge.net/"
SRC_URI="mirror://sourceforge/gputils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/gputils.ps
}

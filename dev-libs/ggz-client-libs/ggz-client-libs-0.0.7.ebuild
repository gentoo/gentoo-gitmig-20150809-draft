# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ggz-client-libs/ggz-client-libs-0.0.7.ebuild,v 1.1 2003/07/10 18:48:05 vapier Exp $

DESCRIPTION="The client libraries for GGZ Gaming Zone"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"
HOMEPAGE="http://ggz.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"

DEPEND=">=dev-libs/libggz-0.0.7
	dev-libs/expat
	dev-libs/popt"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog HACKING NEWS Quick* README* TODO
}

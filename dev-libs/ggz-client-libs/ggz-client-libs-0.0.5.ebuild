# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ggz-client-libs/ggz-client-libs-0.0.5.ebuild,v 1.6 2002/08/14 11:52:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The client libraries for GGZ Gaming Zone"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"
HOMEPAGE="http://ggz.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-libs/libggz-0.0.5
		dev-libs/expat"

src_compile() {
 	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog HACKING NEWS Quick* README* TODO
}

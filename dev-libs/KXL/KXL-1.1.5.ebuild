# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/KXL/KXL-1.1.5.ebuild,v 1.5 2002/10/04 05:13:57 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Development Library for making games for X"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"
HOMEPAGE="http://kxl.hn.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=""

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING README
}

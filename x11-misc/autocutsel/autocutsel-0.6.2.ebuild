# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Synchronise the two copy/paste buffers mainly used by X applications"
HOMEPAGE="http://www.lepton.fr/tools/autocutsel/"
SRC_URI="http://www.lepton.fr/tools/autocutsel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc
	virtual/x11"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

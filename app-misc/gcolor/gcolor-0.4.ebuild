# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gcolor/gcolor-0.4.ebuild,v 1.1 2002/12/26 02:20:14 agenkin Exp $

DESCRIPTION="A simple color selector."
HOMEPAGE="http://gcolor.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="x11-libs/gtk+"

SLOT="0"
KEYWORDS="x86"

SRC_URI="mirror://sourceforge/gcolor/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS INSTALL README AUTHORS COPYING NEWS ChangeLog
}

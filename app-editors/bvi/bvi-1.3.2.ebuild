# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bvi/bvi-1.3.2.ebuild,v 1.4 2006/10/21 14:36:01 nixnut Exp $

DESCRIPTION="display-oriented editor for binary files, based on the vi texteditor"
HOMEPAGE="http://bvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/bvi/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ppc ~ppc-macos ~x86"

DEPEND="sys-libs/ncurses"

src_compile() {
	econf --with-ncurses=/usr || die "econf failed"

	cp bmore.h bmore.h.old
	sed -e 's:ncurses/term.h:term.h:g' bmore.h.old > bmore.h

	emake || die "emake failed"
}

src_install() {
	einstall || die "make install failed"
	rm -rf ${D}/usr/share/bmore.help
	dodoc README CHANGES CREDITS bmore.help
	dohtml -r html/*
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bvi/bvi-1.3.2.ebuild,v 1.7 2006/10/22 20:14:36 kugelfang Exp $

inherit multilib

DESCRIPTION="display-oriented editor for binary files, based on the vi texteditor"
HOMEPAGE="http://bvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/bvi/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc ~ppc-macos ~x86"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:(INSTALL_PROGRAM) -s:(INSTALL_PROGRAM):g' \
		Makefile.in || die "sed failed in Makefile.in"
}

src_compile() {
	econf --with-ncurses=/usr || die "econf failed"

	sed -i -e 's:ncurses/term.h:term.h:g' bmore.h || die "sed failed in bmore.h"

	emake || die "emake failed"
}

src_install() {
	einstall || die "make install failed"
	rm -rf "${D}"/usr/$(get_libdir)/bmore.help
	dodoc README CHANGES CREDITS bmore.help
	dohtml -r html/*
}

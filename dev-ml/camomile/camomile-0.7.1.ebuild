# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camomile/camomile-0.7.1.ebuild,v 1.1 2007/05/26 21:19:46 aballier Exp $

inherit findlib

DESCRIPTION="Camomile is a comprehensive Unicode library for ocaml."
HOMEPAGE="http://camomile.sourceforge.net/"
SRC_URI="mirror://sourceforge/camomile/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND=">=dev-lang/ocaml-3.07"

src_compile() {
	econf $(use_enable debug) || die
	emake -j1
}

src_install() {
	mkdir -p "${D}/usr/bin"
	findlib_src_install DATADIR="${D}/usr/share" BINDIR="${D}/usr/bin"
}

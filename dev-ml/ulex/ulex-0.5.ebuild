# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ulex/ulex-0.5.ebuild,v 1.3 2005/02/17 20:08:07 mattam Exp $

inherit eutils findlib

DESCRIPTION="A lexer generator for unicode"
HOMEPAGE="http://www.cduce.org"
SRC_URI="http://www.cduce.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.08"

src_compile() {
	make all || die
	make all.opt || die
}

src_install() {
	findlib_src_install
	dodoc README CHANGES
}

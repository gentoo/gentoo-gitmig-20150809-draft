# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/confluence/confluence-0.9.1.ebuild,v 1.3 2005/04/01 04:31:57 agriffis Exp $

DESCRIPTION="a functional programming language for reactive system design (digital logic, hard-real-time software)"
HOMEPAGE="http://www.confluent.org/"
SRC_URI="http://www.confluent.org/download/confluence/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha ia64"
IUSE=""

DEPEND="dev-lang/ocaml"

src_compile() {
	make PREFIX=${D}/usr OCAMLLIB=`ocamlc -where` || die
}

src_install() {
	make PREFIX=${D}/usr OCAMLLIB=`ocamlc -where` install || die
	dodoc INSTALL NEWS
}

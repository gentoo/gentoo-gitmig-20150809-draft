# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/confluence/confluence-0.9.1.ebuild,v 1.5 2006/06/20 14:34:49 kingtaco Exp $

DESCRIPTION="a functional programming language for reactive system design (digital logic, hard-real-time software)"
HOMEPAGE="http://www.confluent.org/"
SRC_URI="http://www.confluent.org/download/confluence/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lang/ocaml"

src_compile() {
	make PREFIX=${D}/usr OCAMLLIB=`ocamlc -where` || die
}

src_install() {
	make PREFIX=${D}/usr OCAMLLIB=`ocamlc -where` install || die
	dodoc INSTALL NEWS
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/confluence/confluence-0.9.1.ebuild,v 1.1 2004/08/09 11:16:26 mattam Exp $

DESCRIPTION="a functional programming language for reactive system design (digital logic, hard-real-time software)"
SRC_URI="http://www.confluent.org/download/confluence/${P}.tar.gz"
HOMEPAGE="http://www.confluent.org/"

S="${WORKDIR}/${P}"

DEPEND="dev-lang/ocaml"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha ~ia64"
IUSE=""

src_compile() {
	make PREFIX=${D}/usr OCAMLLIB=`ocamlc -where` || die
}

src_install() {
	make PREFIX=${D}/usr OCAMLLIB=`ocamlc -where` install || die

	dodoc LICENSE_GPL LICENSE_LGPL INSTALL NEWS
}

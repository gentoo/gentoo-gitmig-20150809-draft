# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/facile/facile-1.1.ebuild,v 1.1 2007/09/10 21:01:37 philantrop Exp $

DESCRIPTION="FaCiLe is a constraint programming library on integer and integer set finite domains written in OCaml."
HOMEPAGE="http://www.recherche.enac.fr/log/facile/"
SRC_URI="http://www.recherche.enac.fr/log/facile/distrib/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.09.3-r1"
RDEPEND="${DEPEND}"

src_compile(){
	# This is a custom configure script and it does not support standard options
	./configure --faciledir ${D}$(ocamlc -where)/facile/
	emake || die "Compilation failed"
}

src_install(){
	dodir $(ocamlc -where)
	emake install || die "Installation failed"
	dodoc LICENSE README || die "installing docs failed"
}

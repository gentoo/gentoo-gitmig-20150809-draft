# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/fieldslib/fieldslib-0.1.1.ebuild,v 1.2 2011/01/20 19:54:03 aballier Exp $

EAPI="2"
inherit findlib multilib

DESCRIPTION="Folding over record fields"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	dev-ml/type-conv"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		$(oasis_use_enable debug debug) \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_install() {
	findlib_src_install

	# install documentation
	dodoc README || die
}

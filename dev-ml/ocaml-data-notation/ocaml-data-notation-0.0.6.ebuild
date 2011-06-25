# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-data-notation/ocaml-data-notation-0.0.6.ebuild,v 1.1 2011/06/25 18:56:56 aballier Exp $

EAPI=3

inherit findlib multilib

DESCRIPTION="This project uses type-conv to dump OCaml data structure using OCaml data notation"
HOMEPAGE="https://forge.ocamlcore.org/projects/odn"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/638/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +ocamlopt"

RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
		>=dev-ml/type-conv-2.3.0"
DEPEND="${RDEPEND}
		  dev-ml/ounit[ocamlopt?]
		  dev-ml/ocaml-fileutils[ocamlopt?]"

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	chmod +x configure
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		$(oasis_use_enable debug debug) \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_install() {
	findlib_src_install

	dodoc README.txt || die "doc install failed"
}

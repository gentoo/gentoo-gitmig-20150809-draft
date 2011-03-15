# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-fileutils/ocaml-fileutils-0.4.2.ebuild,v 1.2 2011/03/15 20:05:37 aballier Exp $

EAPI=3

inherit findlib

DESCRIPTION="Pure OCaml functions to manipulate real file (POSIX like) and filename"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocaml-fileutils"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/462/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test +ocamlopt"

RDEPEND=">=dev-lang/ocaml-3.11[ocamlopt?]"
DEPEND="${RDEPEND}
	test? ( dev-ml/ounit )"

src_prepare() {
	use ocamlopt || sed -i -e 's/OCAMLBEST=.*/OCAMLBEST=byte/' configure
}

src_install() {
	findlib_src_preinst
	emake htmldir="${ED}/usr/share/doc/${PF}/html" install || die
	dodoc README CHANGELOG || die "doc isntall failed"
}

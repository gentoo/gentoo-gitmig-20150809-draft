# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/type-conv/type-conv-3.0.4.ebuild,v 1.1 2011/10/06 20:00:53 aballier Exp $

EAPI="2"

inherit findlib eutils multilib

DESCRIPTION="Mini library required for some other preprocessing libraries"
HOMEPAGE="http://forge.ocamlcore.org/projects/type-conv/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/697/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc +ocamlopt"

RDEPEND=">=dev-lang/ocaml-3.12[ocamlopt?]"

DEPEND="${RDEPEND}"

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

src_test() {
	LD_LIBRARY_PATH="${S}/_build/lib" emake test || die
}

src_install() {
	findlib_src_install

	dodoc README.txt Changelog || die
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-expect/ocaml-expect-0.0.2.ebuild,v 1.1 2011/02/22 16:13:07 aballier Exp $

EAPI=3

inherit findlib eutils multilib

DESCRIPTION="Ocaml implementation of expect to help building unitary testing"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocaml-expect/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/475/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc +ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-3.10.2[ocamlopt?]
	dev-ml/extlib
	dev-ml/pcre-ocaml"
DEPEND="${RDEPEND}
	dev-ml/findlib
	dev-ml/ounit"

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	chmod +x configure
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		--htmldir "/usr/share/doc/${PF}/html" \
		$(oasis_use_enable debug debug) \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_compile() {
	emake || die
	if use doc; then
		emake doc || die
	fi
}

src_install() {
	findlib_src_install

	dodoc README.txt CHANGES.txt AUTHORS.txt || die "doc install failed"
}

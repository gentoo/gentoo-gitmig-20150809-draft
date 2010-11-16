# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lwt/lwt-2.1.1.ebuild,v 1.1 2010/11/16 11:27:19 aballier Exp $

EAPI=2

inherit findlib eutils

MY_P=${P/_/+}
DESCRIPTION="Cooperative light-weight thread library for OCaml"
SRC_URI="http://ocsigen.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://ocsigen.org/lwt"

IUSE="gtk doc +ocamlopt ssl"

DEPEND=">=dev-lang/ocaml-3.11[ocamlopt?]
	dev-ml/react
	ssl? ( >=dev-ml/ocaml-ssl-0.4.0 )
	gtk? ( dev-ml/lablgtk dev-libs/glib:2 )"

RDEPEND="${DEPEND}
	!<www-servers/ocsigen-1.1"

SLOT="0"
LICENSE="LGPL-2.1 LGPL-2.1-linking-exception"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

S=${WORKDIR}/${MY_P}

disable_feature() {
	use $1 || sed -i -e "s/ocamlfind query $2/ocamlfind query badpackage/" myocamlbuild.ml
}

src_configure() {
	disable_feature ssl ssl
	disable_feature gtk lablgtk2
}

src_compile() {
	# ocamlbuild is stupid and fails parallel make if it does not exist...
	mkdir _build
	emake byte || die "make failed"
	if use ocamlopt ; then
		emake opt || die "failed to build native code version"
	fi
	if use doc ; then
		emake doc || die "failed to build the documentation"
	fi
}

src_test() {
	chmod +x run_tests.sh || die
	./run_tests.sh || die
}

src_install() {
	findlib_src_preinst
	emake DESTDIR="${OCAMLFIND_DESTDIR}" install || die "install failed"
	dodoc CHANGES README
	if use doc; then
		dohtml _build/lwt.docdir/*.html
	fi
}

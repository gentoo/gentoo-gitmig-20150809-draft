# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-make/ocaml-make-6.24.8.ebuild,v 1.1 2007/05/12 23:04:28 aballier Exp $

DESCRIPTION="Generic O'Caml Makefile for GNU Make"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.06-r1
	>=dev-ml/findlib-0.8"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.bz2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

src_install () {
	# Just put the OCamlMakefile into /usr/include
	# where GNU Make will automatically pick it up.
	insinto /usr/include
	doins OCamlMakefile
	# install documentation
	dodoc README Changes
}

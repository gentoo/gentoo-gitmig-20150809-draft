# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/netclient/netclient-0.90.4.ebuild,v 1.1 2005/03/27 15:18:54 mattam Exp $

inherit findlib

DESCRIPTION="HTTP 1.0/1.1 client OCaml component"
HOMEPAGE="http://www.ocaml-programming.de/programming/netclient.html"
LICENSE="as-is"
DEPEND=">=dev-lang/ocaml-3.08
	dev-ml/equeue
	dev-ml/ocamlnet
	threads? ( dev-ml/xstr )"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc threads"

src_compile() {
	local targets="all opt"
	use threads || targets="non_mt non_mt_opt "
	make ${targets} || die "Compilation failed"
}

src_install () {
	findlib_src_install
	dodoc LICENSE README
	if use doc ; then
		for dir in examples/*
		  do
		  insinto /usr/share/doc/${PF}/$dir
		  doins $dir/*
		done
	fi
}

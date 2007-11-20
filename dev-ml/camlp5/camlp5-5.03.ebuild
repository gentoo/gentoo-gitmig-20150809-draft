# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlp5/camlp5-5.03.ebuild,v 1.1 2007/11/20 13:26:24 aballier Exp $

inherit multilib eutils

DESCRIPTION="A preprocessor-pretty-printer of ocaml"
HOMEPAGE="http://pauillac.inria.fr/~ddr/camlp5/"
SRC_URI="http://pauillac.inria.fr/~ddr/camlp5/distrib/src/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ocaml-3.09"
RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		-prefix /usr \
	    -bindir /usr/bin \
		-libdir /usr/$(get_libdir)/ocaml \
		-mandir /usr/share/man || die "configure failed"

	emake -j1 world.opt || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use doc && dohtml -r doc/*

	dodoc CHANGES DEVEL ICHANGES README UPGRADING MODE
}

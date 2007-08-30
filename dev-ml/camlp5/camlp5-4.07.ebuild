# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlp5/camlp5-4.07.ebuild,v 1.2 2007/08/30 18:37:31 mr_bones_ Exp $

inherit multilib eutils

DESCRIPTION="A preprocessor-pretty-printer of ocaml"
HOMEPAGE="http://pauillac.inria.fr/~ddr/camlp5/"
SRC_URI="http://pauillac.inria.fr/~ddr/camlp5/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.10.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/install_destdir.dpatch"
}

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

	dodoc CHANGES DEVEL ICHANGES README UPGRADING
}

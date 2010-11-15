# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/fort/fort-0.4.2.ebuild,v 1.2 2010/11/15 09:18:49 tomka Exp $

EAPI=2

inherit multilib

DESCRIPTION="provides an environment for testing programs and Objective Caml modules"
HOMEPAGE="http://fort.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="dev-lang/ocaml"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:\$(BINDIR):\$(DESTDIR)&:"\
		-e "s:\$(LIBDIR):\$(DESTDIR)&:" Makefile || die
}

src_configure() {
	./configure --bindir /usr/bin --libdir /usr/$(get_libdir)/ocaml || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README || die
}

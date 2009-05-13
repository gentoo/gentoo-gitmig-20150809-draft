# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bact/bact-0.13.ebuild,v 1.2 2009/05/13 03:45:23 darkside Exp $

inherit toolchain-funcs

DESCRIPTION="Boosting Algorithm for Classification of Trees"
HOMEPAGE="http://chasen.org/~taku/software/bact/"
SRC_URI="http://chasen.org/~taku/software/bact/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_test() {
	make test || die
}

src_install() {
	dobin bact_learn bact_mkmodel bact_classify || die "dobin failed"

	dohtml index.html bact.css || die "dohtml failed"
	dodoc README AUTHORS || die "dodoc failed"
}

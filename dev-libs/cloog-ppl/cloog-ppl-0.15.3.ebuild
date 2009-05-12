# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cloog-ppl/cloog-ppl-0.15.3.ebuild,v 1.5 2009/05/12 14:57:09 jer Exp $

EAPI=2

inherit autotools

DESCRIPTION="Port of CLooG (Chunky LOOp Generator) to PPL (Parma Polyhedra Library)"
HOMEPAGE="http://repo.or.cz/w/cloog-ppl.git"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/infrastructure/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND=">=dev-libs/ppl-0.10
		dev-libs/gmp"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	mkdir "${S}"/m4
	eautoreconf
}

src_configure() {
	econf --with-ppl || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

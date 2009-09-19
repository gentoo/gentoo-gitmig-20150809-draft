# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cloog-ppl/cloog-ppl-0.15.7.ebuild,v 1.2 2009/09/19 23:31:59 aballier Exp $

DESCRIPTION="Port of CLooG (Chunky LOOp Generator) to PPL (Parma Polyhedra Library)"
HOMEPAGE="http://repo.or.cz/w/cloog-ppl.git"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/infrastructure/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/ppl-0.10
		dev-libs/gmp"
DEPEND="${RDEPEND}"

src_compile() {
	econf --with-ppl || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

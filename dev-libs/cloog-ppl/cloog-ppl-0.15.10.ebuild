# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cloog-ppl/cloog-ppl-0.15.10.ebuild,v 1.1 2011/01/06 23:37:14 dirtyepic Exp $

EAPI="3"

inherit autotools-utils

DESCRIPTION="Port of CLooG (Chunky LOOp Generator) to PPL (Parma Polyhedra Library)"
HOMEPAGE="http://repo.or.cz/w/cloog-ppl.git"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/infrastructure/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="static-libs"

RDEPEND="dev-libs/ppl
		dev-libs/gmp"
DEPEND="${RDEPEND}"

src_prepare() {
	mkdir m4
	eautoreconf
}

src_configure() {
	# set includedir to avoid conflicts w/ dev-libs/cloog
	myeconfargs=(
		--with-ppl
		--includedir=/usr/include/cloog-ppl
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	mv "${D}"usr/bin/cloog "${D}"usr/bin/cloog-ppl || die
	mv "${D}"usr/share/info/cloog.info "${D}"usr/share/info/cloog-ppl.info || die
}

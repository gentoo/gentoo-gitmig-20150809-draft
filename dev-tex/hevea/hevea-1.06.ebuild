# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/hevea/hevea-1.06.ebuild,v 1.2 2004/01/05 21:32:10 aliz Exp $

IUSE=""

DESCRIPTION="HeVeA is a quite complete and fast LaTeX to HTML translator"
HOMEPAGE="http://pauillac.inria.fr/~maranget/hevea/"
SRC_URI="ftp://ftp.inria.fr/INRIA/moscova/hevea/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ocaml-2.00"

libdir=/usr/lib/hevea
bindir=/usr/bin

src_compile() {
	make LIBDIR=$libdir BINDIR=$bindir || die
}

src_install() {
	dodir $libdir
	dodir $bindir
	make BINDIR=${D}/$bindir LIBDIR=${D}/$libdir install || die
	insinto /etc/env.d
	doins ${FILESDIR}/99hevea
	dodoc README CHANGES LICENSE
}

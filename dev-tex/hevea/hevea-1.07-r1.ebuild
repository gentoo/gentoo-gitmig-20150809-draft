# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/hevea/hevea-1.07-r1.ebuild,v 1.4 2008/01/02 22:21:37 aballier Exp $

IUSE=""

DESCRIPTION="HeVeA is a quite complete and fast LaTeX to HTML translator"
HOMEPAGE="http://pauillac.inria.fr/~maranget/hevea/"
SRC_URI="ftp://ftp.inria.fr/INRIA/moscova/hevea/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

DEPEND=">=dev-lang/ocaml-3.07"

libdir=/usr/lib/hevea
bindir=/usr/bin

src_compile() {
	make LIBDIR=$libdir BINDIR=$bindir || die
}

src_install() {
	dodir $libdir
	dodir $bindir
	make BINDIR="${D}"/$bindir LIBDIR="${D}"/$libdir install || die

	doenvd "${FILESDIR}"/99hevea

	dodoc README CHANGES
}

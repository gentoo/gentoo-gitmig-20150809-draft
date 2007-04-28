# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/hevea/hevea-1.08.ebuild,v 1.3 2007/04/28 16:17:13 tove Exp $

IUSE=""

DESCRIPTION="HeVeA is a quite complete and fast LaTeX to HTML translator"
HOMEPAGE="http://pauillac.inria.fr/~maranget/hevea/"
SRC_URI="ftp://ftp.inria.fr/INRIA/moscova/hevea/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~sparc ~amd64 ~ppc ~x86"

DEPEND=">=dev-lang/ocaml-3.07"

src_compile() {
	make PREFIX=/usr || die
}

src_install() {
	make PREFIX="${D}"/usr install || die

	doenvd "${FILESDIR}"/99hevea

	dodoc README CHANGES LICENSE
}

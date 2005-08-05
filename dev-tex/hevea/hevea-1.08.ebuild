# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/hevea/hevea-1.08.ebuild,v 1.2 2005/08/05 16:17:35 mkennedy Exp $

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
	make PREFIX=${D}/usr install || die

	insinto /etc/env.d
	doins ${FILESDIR}/99hevea

	dodoc README CHANGES LICENSE
}

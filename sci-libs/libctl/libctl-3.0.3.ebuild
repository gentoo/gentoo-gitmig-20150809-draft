# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libctl/libctl-3.0.3.ebuild,v 1.2 2008/11/08 18:58:13 maekke Exp $

DESCRIPTION="Guile-based library implementing flexible control files for scientific simulations"
SRC_URI="http://ab-initio.mit.edu/libctl/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/libctl/"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"

SLOT="0"
IUSE="examples"

DEPEND=">=dev-scheme/guile-1.6"

src_compile() {
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc NEWS AUTHORS COPYRIGHT ChangeLog
	use examples && doins -r examples
}

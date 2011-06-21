# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/buddy/buddy-2.4.ebuild,v 1.8 2011/06/21 15:41:34 jlec Exp $

EAPI=4

inherit eutils fortran-2

DESCRIPTION="Binary Decision Diagram Package"
HOMEPAGE="http://sourceforge.net/projects/buddy/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos"
IUSE="examples"

DEPEND="
	virtual/fortran
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gold.patch
}

src_install() {
	default

	dodoc doc/*.txt

	insinto /usr/share/doc/${PF}/ps
	doins doc/*.ps

	if use examples; then
		insinto /usr/share/${PN}/
		doins -r examples
	fi
}

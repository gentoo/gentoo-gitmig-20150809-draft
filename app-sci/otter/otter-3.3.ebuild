# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/otter/otter-3.3.ebuild,v 1.2 2004/06/24 22:13:53 agriffis Exp $

DESCRIPTION="An Automated Deduction System."
SRC_URI="http://www-unix.mcs.anl.gov/AR/${PN}/${P}.tar.gz"
HOMEPAGE="http://www-unix.mcs.anl.gov/AR/otter/"

KEYWORDS="~x86"
LICENSE="otter"
SLOT="0"
IUSE=""
DEPEND="virtual/glibc"



src_compile() {
	cd source
	make || die
	cd ${S}/mace2
	make || die
}

src_install() {
	dobin bin/* source/formed/formed
	dodoc README* Legal Changelog Contents documents/*.{tex,ps}
	insinto /usr/share/doc/${PF}
	doins documents/*.pdf
	dohtml index.html
}


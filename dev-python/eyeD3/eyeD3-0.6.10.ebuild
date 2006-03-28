# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.6.10.ebuild,v 1.1 2006/03/28 22:32:08 lucass Exp $


inherit distutils

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
DEPEND=">=dev-lang/python-2.3"

src_compile() {
	econf || die
	distutils_src_compile || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc NEWS TODO
	dohtml README.html
}

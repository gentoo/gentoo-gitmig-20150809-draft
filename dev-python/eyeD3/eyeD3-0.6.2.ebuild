# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.6.2.ebuild,v 1.3 2004/10/19 05:50:17 eradicator Exp $

inherit distutils

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND=">=virtual/python-2.3"

src_compile() {
	econf || die
	distutils_src_compile || die
}

src_install() {
	make DESTDIR="${D}" install || die
}

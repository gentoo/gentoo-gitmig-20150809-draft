# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/duplicity/duplicity-0.4.0.ebuild,v 1.3 2004/06/24 23:42:11 agriffis Exp $

DESCRIPTION="duplicity is a secure backup system using gnupg to encypt data"
HOMEPAGE="http://www.nongnu.org/duplicity/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/python-2.2
	app-crypt/gnupg
	net-libs/librsync"

src_compile() {
	python setup.py build
}

src_install() {
	python setup.py install --prefix=${D}/usr
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/duplicity/duplicity-0.4.0.ebuild,v 1.6 2004/10/24 00:23:00 ticho Exp $

IUSE=""
DESCRIPTION="duplicity is a secure backup system using gnupg to encrypt data"
HOMEPAGE="http://www.nongnu.org/duplicity/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/libc
	>=dev-lang/python-2.2
	<=net-libs/librsync-0.9.5.1"
RDEPEND="${DEPEND}
	app-crypt/gnupg"

src_compile() {
	python setup.py build
}

src_install() {
	python setup.py install --prefix=${D}/usr
}

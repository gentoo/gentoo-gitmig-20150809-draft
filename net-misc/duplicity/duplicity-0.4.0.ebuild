# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/duplicity/duplicity-0.4.0.ebuild,v 1.5 2004/08/04 19:22:02 mholzer Exp $

IUSE=""
DESCRIPTION="duplicity is a secure backup system using gnupg to encrypt data"
HOMEPAGE="http://www.nongnu.org/duplicity/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/libc"
RDEPEND=">=dev-lang/python-2.2
	app-crypt/gnupg
	net-libs/librsync"

src_compile() {
	python setup.py build
}

src_install() {
	python setup.py install --prefix=${D}/usr
}

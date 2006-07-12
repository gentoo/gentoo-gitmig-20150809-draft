# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/iconvcodec/iconvcodec-1.1.2.ebuild,v 1.5 2006/07/12 15:40:16 agriffis Exp $

inherit distutils

DESCRIPTION="Python Codecs for Iconv Encodings"
SRC_URI="http://download.berlios.de/cjkpython/${P}.tar.gz"
HOMEPAGE="http://cjkpython.i18n.org/"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="ia64 x86"

DEPEND=">=dev-lang/python-1.6"

src_compile() {
	distutils_src_compile --with-libc
}

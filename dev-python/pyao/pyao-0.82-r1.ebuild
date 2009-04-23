# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyao/pyao-0.82-r1.ebuild,v 1.1 2009/04/23 13:05:04 patrick Exp $

inherit eutils distutils

DESCRIPTION="Python bindings for the libao library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc -sparc ~x86"
IUSE=""

DEPEND="virtual/python
	>=media-libs/libao-0.8.3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/pyao-fix-deallocation.patch" || die
}

src_compile() {
	./config_unix.py || die
	distutils_src_compile
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins test.py
}

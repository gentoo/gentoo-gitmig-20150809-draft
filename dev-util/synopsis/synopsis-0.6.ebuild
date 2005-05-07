# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/synopsis/synopsis-0.6.ebuild,v 1.5 2005/05/07 19:32:50 dholm Exp $

inherit distutils

DESCRIPTION="Synopsis is a general source code documentation tool."
SRC_URI="http://synopsis.fresco.org/download/${P}.tar.bz2"
HOMEPAGE="http://synopsis.fresco.org/index.html"

DEPEND="virtual/libc
	>=dev-lang/python-2.2"

RDEPEND="${DEPEND}
	media-gfx/graphviz
	net-misc/omniORB"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install

	dohtml -r docs
}

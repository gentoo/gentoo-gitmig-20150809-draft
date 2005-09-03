# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/synopsis/synopsis-0.8.ebuild,v 1.1 2005/09/03 14:14:03 dragonheart Exp $

inherit distutils

DESCRIPTION="Synopsis is a general source code documentation tool."
SRC_URI="http://synopsis.fresco.org/download/${P}.tar.gz"
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

src_install() {
	distutils_src_install
	mv ${D}/usr/share/doc/Synopsis ${D}/usr/share/doc/${PF}
	dohtml -r docs
}

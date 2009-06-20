# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/synopsis/synopsis-0.12.ebuild,v 1.1 2009/06/20 16:16:07 ssuominen Exp $

inherit distutils multilib toolchain-funcs

DESCRIPTION="General source code documentation tool"
HOMEPAGE="http://synopsis.fresco.org/index.html"
SRC_URI="http://synopsis.fresco.org/download/${P}.tar.gz"

RDEPEND="media-gfx/graphviz
	dev-libs/boehm-gc
	net-misc/omniORB"
DEPEND="${RDEPEND}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_compile() {
	tc-export CC CXX
	${python} setup.py config --libdir=/usr/$(get_libdir) \
		--with-gc-prefix=/usr || die
	distutils_src_compile
}

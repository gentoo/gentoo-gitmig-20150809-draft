# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/synopsis/synopsis-0.12.ebuild,v 1.2 2010/05/06 10:33:53 ssuominen Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit distutils eutils multilib python toolchain-funcs

DESCRIPTION="General source code documentation tool"
HOMEPAGE="http://synopsis.fresco.org/index.html"
SRC_URI="http://synopsis.fresco.org/download/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-gfx/graphviz
	dev-libs/boehm-gc
	net-misc/omniORB"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
}

src_configure() {
	tc-export CC CXX
	$(PYTHON) setup.py config --libdir=/usr/$(get_libdir) \
		--with-gc-prefix=/usr || die
}

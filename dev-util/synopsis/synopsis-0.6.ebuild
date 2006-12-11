# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/synopsis/synopsis-0.6.ebuild,v 1.6 2006/12/11 07:40:45 beu Exp $

inherit distutils

DESCRIPTION="Synopsis is a general source code documentation tool."
SRC_URI="http://synopsis.fresco.org/download/${P}.tar.bz2"
HOMEPAGE="http://synopsis.fresco.org/index.html"

RDEPEND="media-gfx/graphviz
	net-misc/omniORB"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_install() {
	distutils_src_install

	dohtml -r docs
}

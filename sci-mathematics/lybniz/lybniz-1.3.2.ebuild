# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/lybniz/lybniz-1.3.2.ebuild,v 1.1 2008/03/25 00:04:02 bicatali Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="A function plotter program written in PyGTK"
HOMEPAGE="http://lybniz2.sourceforge.net/"
SRC_URI="mirror://sourceforge/lybniz2/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-python/pygtk-2.6"

src_unpack() {
	unpack ${A}
	sed -i \
		-e 's/Education;/Education;Math;/' \
		"${S}"/${PN}.desktop || die
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rtgraph/rtgraph-0.70.ebuild,v 1.5 2004/11/05 22:07:23 slarti Exp $

inherit distutils

DESCRIPTION="rtgraph provides several widgets for graphing data in real-time, using PyGTK, and UI components for controlling the graphs."
HOMEPAGE="http://navi.cx/svn/misc/trunk/rtgraph/web/index.html"
SRC_URI="http://navi.picogui.org/releases/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND="virtual/python
	>=dev-python/pygtk-2"

src_install() {
	distutils_src_install
	dodoc README BUGS
	dodir /usr/share/doc/${P}/examples
	insinto /usr/share/doc/${P}/examples
	doins cpu_meter.py graph_ui.py isometric_graph.py line_graph.py \
		polar_graph.py tweak_graph.py
}

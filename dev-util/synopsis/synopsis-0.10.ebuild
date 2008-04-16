# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/synopsis/synopsis-0.10.ebuild,v 1.1 2008/04/16 14:49:58 drac Exp $

inherit distutils

DESCRIPTION="Synopsis is a general source code documentation tool."
HOMEPAGE="http://synopsis.fresco.org/index.html"
SRC_URI="http://synopsis.fresco.org/download/${P}.tar.gz"

RDEPEND="media-gfx/graphviz
	net-misc/omniORB"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kcachegrind/kcachegrind-0.4.5.ebuild,v 1.3 2004/07/03 16:45:43 centic Exp $
inherit kde

IUSE=""
DESCRIPTION="A kde frontend for the cachegrind profiling tool, which is part of valgrind"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://kcachegrind.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=dev-util/calltree-0.9.1
	media-gfx/graphviz"
need-kde 3


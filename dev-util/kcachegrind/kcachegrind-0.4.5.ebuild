# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kcachegrind/kcachegrind-0.4.5.ebuild,v 1.4 2004/07/25 22:02:43 carlo Exp $

inherit kde

DESCRIPTION="A kde frontend for the cachegrind profiling tool, which is part of valgrind"
HOMEPAGE="http://kcachegrind.sourceforge.net"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="!kde-base/kdesdk"
RDEPEND="!kde-base/kdesdk
	>=dev-util/calltree-0.9.1
	media-gfx/graphviz"
need-kde 3


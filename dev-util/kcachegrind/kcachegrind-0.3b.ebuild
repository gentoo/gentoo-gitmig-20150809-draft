# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kcachegrind/kcachegrind-0.3b.ebuild,v 1.1 2003/05/23 10:40:56 pauldv Exp $
inherit kde-base

need-kde 3

IUSE=""
DESCRIPTION="A kde frontend for the cachegrind profiling tool, which is part of valgrind"
SRC_URI="mirror://sourceforge/kcachegrind/${P}.tar.gz"
HOMEPAGE="http://kcachegrind.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="$RDEPEND >=dev-util/calltree-0.2.95"

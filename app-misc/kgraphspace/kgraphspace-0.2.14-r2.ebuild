# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kgraphspace/kgraphspace-0.2.14-r2.ebuild,v 1.9 2002/10/19 15:48:49 aliz Exp $

inherit kde-base || die

DESCRIPTION="A Disk space utility "
SRC_URI="mirror://sourceforge/kgraphspace/${P}.tar.bz2"
HOMEPAGE="http://kgraphspace.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 2.0

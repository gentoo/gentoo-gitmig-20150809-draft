# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kgraphspace/kgraphspace-0.3.0_pre1.ebuild,v 1.9 2004/06/19 03:29:45 mr_bones_ Exp $

inherit kde
need-kde 3

DESCRIPTION="A Disk space utility "
HOMEPAGE="http://kgraphspace.sourceforge.net"
SRC_URI="mirror://sourceforge/kgraphspace/${P//_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S="$WORKDIR/${P//_/-}"

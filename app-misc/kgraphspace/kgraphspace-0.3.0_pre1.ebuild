# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kgraphspace/kgraphspace-0.3.0_pre1.ebuild,v 1.8 2004/03/14 17:21:37 mr_bones_ Exp $

inherit kde

DESCRIPTION="A Disk space utility "
SRC_URI="mirror://sourceforge/kgraphspace/${P//_/-}.tar.bz2"
S=$WORKDIR/${P//_/-}
HOMEPAGE="http://kgraphspace.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3

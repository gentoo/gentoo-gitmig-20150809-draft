# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/kgraphspace/kgraphspace-0.3.0_pre1.ebuild,v 1.2 2002/07/25 17:20:02 seemant Exp $
inherit kde-base || die

DESCRIPTION="A Disk space utility "
SRC_URI="mirror://sourceforge/kgraphspace/${P//_/-}.tar.bz2"
S=$WORKDIR/${P//_/-}
HOMEPAGE="http://kgraphspace.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3
